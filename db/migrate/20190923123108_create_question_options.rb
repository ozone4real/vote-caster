class CreateQuestionOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :question_options do |t|
      t.string :option, unique: true
      t.timestamps
    end

    create_table :poll_question_options do |t|
      t.references :question_option
      t.references :poll
      t.timestamps
    end
  end
end
