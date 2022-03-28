class RenameColumnToUsersIsAdmin < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :is_admin, :admin
  end
end
