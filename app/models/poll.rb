class Poll < ActiveRecord::Base
  belongs_to :creator,  -> { where admin: true }, class_name: "User", foreign_key: "user_id"
  has_many :poll_question_options
  has_many :question_options, through: :poll_question_options
end