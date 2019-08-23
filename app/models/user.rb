class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password

  has_many :messages, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_messages
    Message.where(user_id: self.following_ids + [self.id])
  end

  has_many :favorites, dependent: :destroy
  has_many :favmessages, through: :favorites, source: :message
  
  def favorite(message)
    favorites.find_or_create_by(message_id: message.id)
  end

  def unfavorite(message)
    favorite = favorites.find_by(message_id: message.id)
    favorite.destroy if favorite
  end

  def favmessage?(message)
    self.favmessages.include?(message)
  end
  
  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end
  
  has_many :comments, dependent: :destroy
  has_many :comment_messages, through: :comments, source: :message
  
  def comment(message)
    self.comments.find_or_create_by(message_id: message.id)
  end
  
  def uncomment(message)
    comment = self.comments.find_by(message_id: message.id)
    comment.destroy if comment
  end
  
  def comment?(message)
    self.comment_messages.include?(message)
    
  end
  
  has_many :from_talks, class_name: "Talk",
            foreign_key: "from_id", dependent: :destroy
  has_many :to_talks, class_name: "Talk",
            foreign_key: "to_id", dependent: :destroy
  has_many :sent_talks, through: :from_talks, source: :from
  has_many :received_talks, through: :to_talks, source: :to
  
  def send_talk(other_user, room_id, content)
    from_talks.create!(to_id: other_user.id, room_id: room_id, content: content)
  end

end
