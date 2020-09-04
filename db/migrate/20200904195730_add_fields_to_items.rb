class AddFieldsToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :inventory_quantity, :integer
    add_column :items, :image, :string
    add_column :items, :nutrition, :text
  end
end
