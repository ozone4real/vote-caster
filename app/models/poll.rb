class Poll < ActiveRecord::Base
  belongs_to :creator,  -> { where admin: true }, class_name: "User", foreign_key: "user_id"
  has_many :question_options, dependent: :destroy
  scope :active_polls, -> { where("'#{Time.now}' < expires_at")}
  scope :expired_polls, -> { where("'#{Time.now}' > expires_at")}

  def active?
    "#{Time.now}" < expires_at
  end

  def votes_count
    question_options.includes(:votes).map(&:votes).flatten.size
  end

end