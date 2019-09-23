class PollQuestionOption < ActiveRecord::Base
  belongs_to :poll
  belongs_to :question_option
end