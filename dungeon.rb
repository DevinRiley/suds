require File.expand_path('player.rb')
require File.expand_path('item_list.rb')
require File.expand_path('dungeon_map.rb')

# This class is intended to serve as the  orchestrator of game logic and state.
# It passes its responsibilities off to other classes where possible
# but it is the central hub for progression through the game. It will
# become more useful if additional features are added, like NPCs and 
# items, etc.
module SUDS
  class Dungeon
    PATHS = %w(north east south west up down)
    # initialize the player and the dungeon map when the class loads
    @player = Player.new
    @items  = ItemList.create(YAML.load_file('item_file.yml'))
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
      @map[@player.current_room].description
    end

    def self.inspect_current_room
      description = String.new
      current_items.each do |item|
        item_description = @items[item['name']].description
        if description.empty?
          description += "You see #{item_description}"
        else
          description += " and #{item_description}" if !description.empty?
        end
      end
      description.empty? ? "Upon further inspection this room is boring." : description + '.'
    end

    def self.current_items
      @map[@player.current_room].items
    end

    def self.first_room_name
      @map.first_room.name
    end

  end
end