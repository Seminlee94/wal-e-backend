class AddReceiptInfoColumnItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :receipt_info, :string
  end
end
