class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, :dependent => :destroy

  validates :question, presence: true
end
