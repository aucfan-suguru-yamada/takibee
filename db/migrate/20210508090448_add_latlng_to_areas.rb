class AddLatlngToAreas < ActiveRecord::Migration[6.0]
  def change
    add_column :areas, :latlng, :string
  end
end
