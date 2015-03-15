module SUDS
	class Dungeon
		PATHS = %w(north east south west up down)
		# initialize the player and the dungeon map when the class loads
		@player = Player.new
		@map    = DungeonMap.new(YAML.load_file('dungeon_map.yml')['rooms'])

		# Define all map traversal methods dynamically (e.g. go_north).
		# All they do is call the traverse method with a path.
		PATHS.each do |path|
			define_singleton_method "go_#{path}" do
				traverse(path)
			end
		end

		# travels the desired path and returns the next description
		def self.traverse(path)
			destination = @map.traverse(@player.current_room, path)
			if !destination.nil?
				@player.current_room = destination.name
				return describe_current_room
			else
				return "You can't go #{path}."
			end
		end

		def self.describe_current_room
			@map.get_room(@player.current_room).description
		end

		def self.first_room_name
			@map.first_room.name
		end

	end
end