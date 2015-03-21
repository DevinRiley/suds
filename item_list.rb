module SUDS
	Item = Struct.new(:name, :type, :category, :description)

	# This class is a factory for Item structs.
	class ItemList
		def self.create(item_list)
			return parse_list(item_list)
		end

		private

		def self.parse_list(item_list)
		  item_list.map { |item| Item.new(*item.values) }
		end

	end
end