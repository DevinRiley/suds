require 'spec_helper'

module SUDS
	describe CommandManager do
		it "responds to all of its own methods and returns a string" do
			CommandManager::COMMANDS.each do |command, method|
				expect(CommandManager.send(command).class).to eq String
				expect(CommandManager.send(command)).to_not include("Invalid")
			end
		end

		it "returns an invalid message response even if it receives a batshit method call" do
			expect{ CommandManager.batshit }.to_not raise_error
			expect(CommandManager.batshit).to include("Invalid")
		end

	end
end