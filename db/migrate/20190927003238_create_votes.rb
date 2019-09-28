class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :user
      t.references :question_option
      t.timestamps
    end
    add_index :votes, [:user_id, :question_option_id], unique: true
  end
end
