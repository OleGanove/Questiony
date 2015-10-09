class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  # Users can only answer a question once
  validates :user_id, uniqueness: { scope: [:question_id], message: "You have already answered the question" }
end
