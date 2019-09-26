class AddQuestionTypeToPolls < ActiveRecord::Migration[5.2]
  def change
    add_column :polls, :question_type, :string
    add_column :polls, :duration, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
