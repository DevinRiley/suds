require 'spec_helper'

module SUDS
	describe CommandManager do
		describe "available commands" do
			after(:each) { Dungeon.load() }
			it { expect{described_class.N}.to_not raise_error }
			it { expect{described_class.E}.to_not raise_error }
			it { expect{described_class.S}.to_not raise_error }
			it { expect{described_class.W}.to_not raise_error }
			it { expect{described_class.L}.to_not raise_error }
			it { expect{described_class.I}.to_not raise_error }
			it { expect{described_class.T('item_name')}.to_not raise_error }
			it { expect{described_class.inventory}.to_not raise_error }
			it { expect{described_class.help}.to_not raise_error }			
		end

		it "returns an invalid message response even if it receives a batshit method call" do
			expect{ CommandManager.batshit }.to_not raise_error
			expect(CommandManager.batshit).to include("Invalid")
		end

	end
end