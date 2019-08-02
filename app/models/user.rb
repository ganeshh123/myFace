class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_voter

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy
  has_friendship
  

  validates :username, uniqueness: true
  validates :email, uniqueness: true

  def unreadcount
    @user = self
    count = 0
    @conversations = Conversation.all.select { |conversation| conversation.user1_id == @user.id || conversation.user2_id == @user.id}
    if !@conversations.empty?
      @conversations.each do |c|
        if !c.messages.empty?
          m = c.messages.last
          f = User.find(m.user_id) 
          if !m.read && f != @user
              count = count + 1
          end
        end
      end
    end
    return count
  end

  def notificationcount
    @user = self
    count = 0
    return @user.unreadcount + @user.requested_friends.size
  end

 


end
