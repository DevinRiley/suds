module SUDS
	class DungeonMap
		Node = Struct.new(:name, :description, :edges) do
			def add_edge(key, node)
				edges[key] = node
			end

			def traverse(edge_key)
				edges[edge_key] unless edges.empty?
			end
		end

		attr_reader :nodes

		def initialize(source)
			parse_graph(source)
		end

		def traverse(current, path)
			node = @nodes[current] and node.traverse(path)
		end

		def first_room
			@nodes.first.last
		end

		def get_room(name)
			@nodes[name]
		end

		private 

		def parse_graph(rooms)
			@nodes = rooms.inject({}) do |result, el| 
				result[el['name']] = Node.new(el['name'], el['description'], {})
				result
			end
			add_edges(rooms)
		end

		# for each room, add a reference to the edge nodes now that they're all in memory
		def add_edges(rooms)
			rooms.each do |room|
				room['links'].each do |link_key, link_value|
					@nodes[room['name']].add_edge(link_key, @nodes[link_value])
				end
			end
		end

	end
end