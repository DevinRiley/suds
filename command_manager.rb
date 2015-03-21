require File.expand_path('dungeon.rb')
# This class is designed to handle all the user input,
# route it to the appropriate places, and return a string
# to display to the user.
module SUDS
	class CommandManager
		COMMANDS = {
			'N' => 'go_north',
			'E' => 'go_east',
			'S' => 'go_south',
			'W' => 'go_west',
			'L' => 'describe_current_room',
			'help' => 'show_help'
		}

		# if command manager doesn't have the method we're
		# trying to call, try it on the Dungeon class.
	  def self.method_missing(command)
	  	command = command.to_s
			if COMMANDS.has_key?(command)
				return Dungeon.send(COMMANDS[command])
			else
				"Invalid command, type 'help' for a list of commands"
			end
	  end

		private

		# The help command just prints back our commands hash
		# except for the help command itself
		def self.help
			COMMANDS.reject { |k| k == 'help' }.to_s
		end



	end
end