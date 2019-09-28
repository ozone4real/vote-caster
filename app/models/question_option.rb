class QuestionOption < ActiveRecord::Base
 belongs_to :polls
 has_many :votes, dependent: :destroy
end