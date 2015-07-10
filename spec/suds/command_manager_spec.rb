require 'spec_helper'

module SUDS
	describe CommandManager do
		describe "available commands" do
      let(:player) { Player.new() }
			after(:each) { Dungeon.load() }
			it { expect{described_class.N(player)}.to_not raise_error }
			it { expect{described_class.E(player)}.to_not raise_error }
			it { expect{described_class.S(player)}.to_not raise_error }
			it { expect{described_class.W(player)}.to_not raise_error }
			it { expect{described_class.L(player)}.to_not raise_error }
			it { expect{described_class.I(player)}.to_not raise_error }
			it { expect{described_class.T('item_name', player)}.to_not raise_error }
			it { expect{described_class.U('item_name', player)}.to_not raise_error }
			it { expect{described_class.inventory(player)}.to_not raise_error }
			it { expect{described_class.help(player)}.to_not raise_error }
		end

		it "returns an invalid message response even if it receives a batshit method call" do
			expect{ CommandManager.batshit }.to_not raise_error
			expect(CommandManager.batshit).to include("Invalid")
		end

	end
end
