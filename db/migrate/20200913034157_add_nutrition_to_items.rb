class AddNutritionToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :nutrition, :text
  end
end
