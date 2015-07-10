require 'yaml'
# This class is intended to serve as the  orchestrator of game logic and state.
# It passes its responsibilities off to other classes where possible
# but it is the central hub for progression through the game. It will
# become more useful if additional features are added, like NPCs etc.
module SUDS
  class Dungeon
    PATHS = %w(north east south west up down)

    # Initialize the player and the dungeon map when the class loads.
    # Wrapping this initialization in a method so that this singleton
    # class is easier to test.
    def self.load
      config_directory = File.expand_path('../../../config/', __FILE__)
      @items  = ItemList.create(YAML.load_file(config_directory + '/item_file.yml'))
      @map    = DungeonMap.new(YAML.load_file(config_directory + '/dungeon_map.yml')['rooms'])
    end
    load()

    # Define all map traversal methods dynamically (e.g. go_north).
    # All they do is call the traverse method with a path.
    PATHS.each do |path|
      define_singleton_method("go_#{path}") do |player|
        traverse(path, player)
      end
    end

    # travels the desired path and returns the next description
    def self.traverse(path, player)
      destination = @map.traverse(player.current_room, path)
      if destination
        player.current_room = destination.name
        return describe_current_room(player)
      else
        return "You can't go #{path}."
      end
    end

    def self.describe_current_room(player)
      @map[player.current_room].description
    end

    # returns a string that describes the items in the current room
    def self.inspect_current_room(player)
      return "Upon further inspection this room is boring." if current_items(player).empty?

      description = String.new
      current_items(player).each do |item_name|
        item_description = @items[item_name].description
        description += description.empty? ? "You see ":  " and "
        description += item_description
      end
      description + '.'
    end

    # if the item is in the room, add it to the player's
    # inventory and remove it from the room.

    def self.take_item(item_name, player)
      return "There is no #{item_name} here." unless current_items(player).include?(item_name)
      try_to_give_item_to_player(item_name, player)
    end

    def self.use_item(item_name, player)
      player.use_item(item_name)
      "#{item_name} used."
    end

    # TODO: might be nice to have the command manager
    # figure out who the player is so we don't have
    # to use this pass-through method
    def self.show_inventory(player)
      player.show_inventory
    end

    def self.current_items(player)
      @map[player.current_room].items
    end

    def self.first_room_name
      @map.first_room.name
    end

    private

    def self.remove_item_from_room(item_name, player)
      current_items(player).delete(item_name)
    end

    def self.try_to_give_item_to_player(item_name, player)
      if player.add_to_inventory(item_name)
        remove_item_from_room(item_name, player)
        return "#{item_name} taken."
      else
        return "There's not enough room in your inventory to take #{item_name}"
      end
    end

  end
end
