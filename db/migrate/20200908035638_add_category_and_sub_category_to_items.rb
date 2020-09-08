class AddCategoryAndSubCategoryToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :category, :string
    add_column :items, :sub_category, :string
  end
end
