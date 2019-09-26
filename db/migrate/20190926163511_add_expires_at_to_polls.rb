class AddExpiresAtToPolls < ActiveRecord::Migration[5.2]
  def change
    remove_column :polls, :duration
    add_column :polls, :expires_at, :datetime
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
