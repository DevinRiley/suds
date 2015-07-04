module SUDS
  Item = Struct.new(:name, :type, :category, :description)

  # This class is a factory for Item structs.
  class ItemList
    def self.create(item_list)
      return parse_list(item_list)
    end

    private

    def self.parse_list(item_list)
      item_list.inject({}) do |result, item|
        result[item['name']] = Item.new(*item.values)
        result
      end
    end

  end
end