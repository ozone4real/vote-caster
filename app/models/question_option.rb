class QuestionOption < ActiveRecord::Base
 belongs_to :polls
 has_many :votes, dependent: :destroy

 def user_vote?(user)
  votes.map(&:user_id).include? user.id
 end
end