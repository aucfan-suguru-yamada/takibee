class AddMakerIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :maker_id, :integer
  end
end
