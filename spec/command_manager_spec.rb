require 'spec_helper'

module SUDS
	describe CommandManager do
		# TODO: Just write expectations for each command
		# rather than trying to do it dynamically.
		xit "responds to all of its own methods and returns a string" do
			CommandManager::COMMANDS.each do |command, method|
				puts "Command, Method: #{command}, #{method}"
				expect(CommandManager.send(command).class).to eq String
				expect(CommandManager.send(command)).to_not include("Invalid")
			end
		end

		it "responds to the 'U' command to use an item" do
			expect(CommandManager.U('item')).to_not include("Invalid")
		end

		it "returns an invalid message response even if it receives a batshit method call" do
			expect{ CommandManager.batshit }.to_not raise_error
			expect(CommandManager.batshit).to include("Invalid")
		end

	end
end