require File.expand_path('player.rb')
require File.expand_path('item_list.rb')
require File.expand_path('dungeon_map.rb')

# This class is intended to serve as the  orchestrator of game logic and state.
# It passes its responsibilities off to other classes where possible
# but it is the central hub for progression through the game. It will
# become more useful if additional features are added, like NPCs etc.
module SUDS
  class Dungeon
    attr_reader :player
    PATHS = %w(north east south west up down)

    # Initialize the player and the dungeon map when the class loads.
    # Wrapping this initialization in a method so that this singleton
    # class is easier to test.
    def self.load
      @player = Player.new
      @items  = ItemList.create(YAML.load_file('item_file.yml'))
      @map    = DungeonMap.new(YAML.load_file('dungeon_map.yml')['rooms'])
    end
    load()

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
      @map[@player.current_room].description
    end

    # returns a string that describes the items in the current room
    def self.inspect_current_room
      return "Upon further inspection this room is boring." if current_items.empty?
      description = String.new
      current_items.each do |item|
        if description.empty?
          description += "You see "
        else
          description += " and "
        end
        description += @items[item['name']].description
      end
      description + '.'
    end

    # if the item is in the room, add it to the player's
    # inventory and remove it from the room.
    def self.take_item(item_name)
      return "There is no #{item_name} here." if !current_items.include?("name" => item_name)
      try_to_give_item_to_player(item_name)
    end

    def self.use_item(item_name)
      @player.use_item(item_name)
      "#{item_name} used."
    end

    # TODO: might be nice to have the command manager
    # figure out who the player is so we don't have
    # to use this pass-through method
    def self.show_inventory
      @player.show_inventory
    end

    def self.current_items
      @map[@player.current_room].items
    end

    def self.first_room_name
      @map.first_room.name
    end

    private

    def self.try_to_give_item_to_player(item_name)
      if @player.add_to_inventory(item_name)
        remove_item_from_room(item_name)
        return "#{item_name} taken."
      else
        return "There's not enough room to take #{item_name}"
      end
    end

    def self.remove_item_from_room(item_name)
      current_items.delete('name' => item_name)
    end

  end
end