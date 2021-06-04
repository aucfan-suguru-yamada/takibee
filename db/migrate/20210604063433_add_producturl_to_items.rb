class AddProducturlToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :product_url, :string
  end
end
