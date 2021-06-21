class RenameRemeberDigestColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :remeber_digest, :remember_digest
  end
end
