class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :item_id
      t.string :name
      t.float :sales_price
      t.text :description
      t.timestamps
    end
  end
end
