module SUDS
	class Player
		attr_writer :current_room

    def initialize
      @inventory = Hash.new(0)
    end

    def add_to_inventory(item_name)
      @inventory[item_name] += 1 and return true
    end

    def show_inventory
      @inventory.to_s
    end

		# returns the player's current room name.  Defaults to
		# the first room in the dungeon.
		def current_room
			@current_room ||= Dungeon.first_room_name
		end
	end
end