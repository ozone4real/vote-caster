class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_many :polls, dependent: :destroy
  has_many :votes

  def voted?(poll)
    options = poll.question_options.includes(:votes)
    options.map do |option|    
      option.votes.map(&:user_id)
    end.flatten.include? self.id
  end
end