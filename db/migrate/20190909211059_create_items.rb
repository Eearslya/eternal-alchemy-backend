class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false, default: ''
      t.string :icon
      t.string :description
      t.string :item_type, null: false
      t.string :rarity, null: false
      t.integer :level
      t.integer :vendor_value
      t.integer :default_skin
      t.jsonb :data, default: '{}'

      t.timestamps
    end
  end
end
