require 'spec_helper'

module SUDS
  describe Dungeon do
    let(:map_data) { YAML.load_file('spec/fixtures/test_map.yml')['rooms'] }
    let(:map) { DungeonMap.new(map_data) }
    let(:items) { ItemList.create(YAML.load_file('spec/fixtures/test_items.yml')) }
    let(:player) { Player.new() }

    before(:each) do
      Dungeon.instance_variable_set(:@items, items)
      Dungeon.instance_variable_set(:@map, map)
      player.instance_variable_set(:@current_room, Dungeon.first_room_name)
    end

    describe "::traverse" do
      it "doesn't raise an error when called and returns a string" do
        expect{Dungeon.traverse('north', player)}.to_not raise_error
        expect(Dungeon.traverse('east', player).class).to eq String
      end

      it "tells you when you can't travel in a direction" do
        expect(Dungeon.traverse('wrong', player)).to include("You can't go")
      end
    end

    describe "::describe_current_room" do
      it "returns a string" do
        expect(Dungeon.describe_current_room(player).class).to eq String
      end
    end

    describe "::first_room_name" do
      it "returns a string" do
        expect(Dungeon.first_room_name.class).to eq String
      end
    end

    describe "::inspect_current_room" do
      it "returns a string that describes the items in the room" do
        expect{Dungeon.inspect_current_room(player)}.to_not raise_error
        expect(Dungeon.inspect_current_room(player).class).to eq String
        expect(Dungeon.inspect_current_room(player)).to eq 'You see fixture item for testing.'
      end
    end

    describe "::take_item" do
      before(:each) do
        Dungeon.instance_variable_set(:@items, items)
        Dungeon.instance_variable_set(:@map, map)
        player.current_room = Dungeon.first_room_name
      end

      it "takes an item from the room and puts into players inventory" do
        expect{Dungeon.take_item('item_name', player)}.to_not raise_error
        expect(Dungeon.take_item('Fixture', player)).to eq "Fixture taken."
        expect(Dungeon.take_item('Fixture', player)).to eq "There is no Fixture here."
      end

      after(:all) { Dungeon.load() }
    end

  end
end
