class AddAdminUserToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin_user, :boolean, default: false
  end
end
