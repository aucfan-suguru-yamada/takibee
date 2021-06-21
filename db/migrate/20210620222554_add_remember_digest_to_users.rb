class AddRememberDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :remeber_digest, :string
  end
end
