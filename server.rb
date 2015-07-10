require 'socket'
require 'yaml'
require File.expand_path('command_manager.rb')

# TODO:
# Make into a gem with proper directory structure
# Add tests     

module SUDS
  class Server
    PORT = 1337

    # Open socket on desired port
    # When a client connects, read in commands.
    # Each command should perform some action
    # Actions are specified by your dungeon file
    def initialize
      @server = TCPServer.new(PORT)
    end

    # Start the server
    def run!
      puts "Running server..."
      # accept an incoming connection and listen for
      # newline-separated input.
      # we will persist this connection until the client
      # disconnects or the server exits
      # NOTE: This method call blocks, so once a single connection
      # is established, no new connections will be made
      # until this connection is closed.      
      Socket.accept_loop(@server) do |socket|
        puts 'Accepted incoming connection...'

        begin
          socket.puts(welcome_message)
          while command = socket.gets do
            response = handle(command)
            socket.puts(response)
          end
        ensure
          puts "Closing connection..."
          socket.close
        end
      end
    end

    private

    def welcome_message
      "Welcome to SUDS, the spookiest single-user dungeon game around.\
      Type 'help' for available commands\n" + Dungeon.describe_current_room
    end
    # read in the player command, validate it, and perform the action
    def handle(command)
      # the command manager will deal with validating and
      # returning the requested output
      CommandManager.send(*command.strip.split)
    end

  end
end
