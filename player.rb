module SUDS
	class Player
		attr_writer :current_room

		# returns the player's current room name.  Defaults to
		# the first room in the dungeon.
		def current_room
			@current_room ||= Dungeon.first_room_name
		end
	end
end