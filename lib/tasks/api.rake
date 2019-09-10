# frozen_string_literal: true

namespace :api do
  desc 'Update the local database of items from the API'
  task items: :environment do
    def openstruct_to_hash(object, hash = {})
      object.each_pair do |key, value|
        hash[key] = value.is_a?(OpenStruct) ? openstruct_to_hash(value) : value
      end
      hash
    end

    client = GW2API::Client.new
    puts 'Fetching item data...'
    items = client.items.all
    puts "Committing #{items.length} items..."
    current_slice = 1
    items.each_slice(1000) do |chunk|
      chunk.each_slice(100) do |slice|
        Item.transaction do
          slice.each do |item_data|
            id = item_data.id
            item = Item.find_or_initialize_by(id: id)
            item.name = item_data.name
            item.icon = item_data.icon
            item.description = item_data.description
            item.item_type = item_data.type
            item.rarity = item_data.rarity
            item.level = item_data.level
            item.vendor_value = item_data.vendor_value
            item.default_skin = item_data.default_skin
            item.data = openstruct_to_hash(item_data).to_json
            item.save
          end
        end
        print '.'
      end
      done = current_slice * 1000
      print done.to_s
      current_slice += 1
    end
    puts ''
    puts 'Complete!'
  end

end
