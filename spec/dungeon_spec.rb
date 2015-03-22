require 'spec_helper'

module SUDS
  describe Dungeon do
    describe "::traverse" do
      it "doesn't raise an error when called and returns a string" do
        expect{Dungeon.traverse('north')}.to_not raise_error
        expect(Dungeon.traverse('east').class).to eq String
      end

      it "tells you when you can't travel in a direction" do
        expect(Dungeon.traverse('wrong')).to include("You can't go")
      end
    end

    describe "::describe_current_room" do
      it "returns a string" do
        expect{Dungeon.describe_current_room}.to_not raise_error
        expect(Dungeon.describe_current_room.class).to eq String
      end
    end

    describe "::first_room_name" do
      it "returns a string" do
        expect{Dungeon.first_room_name}.to_not raise_error
        expect(Dungeon.first_room_name.class).to eq String
      end
    end

    describe "::inspect_current_room" do
      it "returns a string that describes the items in the room" do
        expect{Dungeon.inspect_current_room}.to_not raise_error
        expect(Dungeon.inspect_current_room.class).to eq String
      end
    end
  end
end