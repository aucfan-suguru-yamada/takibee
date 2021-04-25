class CreateCamps < ActiveRecord::Migration[6.0]
  def change
    create_table :camps do |t|
      t.string :title, null: false
      t.text :note
      t.integer :number_of_people
      t.belongs_to :user, index: true, foreign_key: true
      t.date :camped_on

      t.timestamps
    end
  end
end
