class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_messageable
  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#", friend: "50x50#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :friendships
  has_many :passive_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  #Types of friends

  #current_user answers question, other person likes answer
  has_many :active_friends, -> { where(friendships: { approved: true}) }, :through => :friendships, :source => :friend

  #other person writes answer, current_user likes answer
  has_many :passive_friends, -> { where(friendships: { approved: true}) }, :through => :passive_friendships, :source => :user

  #current_user answers question, other person does nothing.
  has_many :pending_friends, -> { where(friendships: { approved: false}) }, :through => :friendships, :source => :friend

  #other person writes answer, current_user does nothing.
  has_many :requested_friendships, -> { where(friendships: { approved: false}) }, :through => :passive_friendships, :source => :user

  def friends
  	active_friends | passive_friends
  end

  def friends_with?(person)
    friendships.where(friend_id: person.id, approved: true).any? || 
    person.friendships.where(friend_id: self.id, approved: true).any? 
  end

  def mailboxer_name
    self.name
  end

  def mailboxer_email(object)
    self.email
  end
end
