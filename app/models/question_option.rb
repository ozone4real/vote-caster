class QuestionOption < ActiveRecord::Base
 has_many :poll_question_options
 has_many :polls, through: :poll_question_options
end