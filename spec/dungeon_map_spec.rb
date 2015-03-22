require 'spec_helper'

module SUDS
  describe DungeonMap do
    let(:map_file) { YAML.load_file('spec/fixtures/test_map.yml')['rooms'] }
    let(:map) { DungeonMap.new(map_file) }

    it "#traverse correctly traverses the test map and returns a node on the map" do
      north_node = map.traverse('first_room', 'north')
      east_node = map.traverse('first_room', 'east')
      south_node = map.traverse('first_room', 'south')
      west_node = map.traverse('first_room', 'west')
      expect(north_node.class).to eq DungeonMap::Node
      expect(north_node).to eq map['north_room']
      expect(east_node).to eq map['east_room']
      expect(south_node).to eq map['south_room']
      expect(west_node).to eq map['west_room']
    end

    it "#[] returns a node with the specified name" do
      first_room = map['first_room']
      expect(first_room.class).to eq DungeonMap::Node
      expect(first_room.description).to eq 'starting test room'
    end

    it "#first_room returns the first node listed in the dungeon map file" do
      expect(map.first_room.class).to eq DungeonMap::Node
      expect(map.first_room.name).to eq 'first_room'
    end

    it "#initialize parses a hash structure specifying the map"  do
      expect{DungeonMap.new()}.to raise_error
      expect(map.nodes).to_not eq nil
    end

    it "sets item names in their respective rooms" do
      expect(map.first_room.items.class).to eq Array
      expect(map.first_room.items.first).to eq 'Fixture'
    end

    describe DungeonMap::Node do
      it "accepts an array of items as last argument" do
        args = ['a', 'b', 'c', ['test', 'array']]
        node = DungeonMap::Node.new(*args)
        expect(node.items.class).to eq Array
        expect(node.items).to eq ['test', 'array']
      end
    end
  end
end
