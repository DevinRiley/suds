# SUDS: the Single-User Dungeon Server

SUDS began as fun weekend project to set up a text-based adventure game server
and game framework.  The original idea was to make a MUD server and framework,
but I didn't get around to writing the multi-user part of the MUD server so
SUDS was born :).  The SUDS server supports one user at a time and does not
persist game state between sessions.  Thats ok, because all you can do right
now is walk around anyway.

SUDS provides a game server and a ```dungeon_map.yml``` file which describes the dungeon the player will play in.
You can create your own dungeon_map.yml file to create your own dungeon rooms, just follow the format
of the original file.

## Getting Started

1. Clone the repo
```
  $ git clone git@github.com:DevinRiley/suds.git
```
2. Run the server from the suds directory
```
  $ bin/server
```
3. Use netcat as a client to connect to the server and play the game
```
  nc localhost 1337
```


