class DropPollQuestionOptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :question_options, :poll
  end
end
