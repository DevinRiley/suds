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

	  def self.method_missing(command)
	  	command = command.to_s
			if COMMANDS.has_key?(command)
				return Dungeon.send(COMMANDS[command])
			else
				"Invalid command, type 'help' for a list of commands"
			end
	  end

		private

		def self.help
			COMMANDS.reject { |k| k == 'help' }
		end



	end
end