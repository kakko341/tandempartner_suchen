class Message < ApplicationRecord
    belongs_to :user
    has_many_attached :images
        
    validates :content, presence: true, length: {maximum: 255}
    validates :title, presence: true, length: {maximum: 255}
    
    has_many :favorites, foreign_key: 'message_id', dependent: :destroy
    has_many :users, through: :favorites
    
    def self.search(search)
        if search
          where(["title LIKE? or content LIKE?", "%#{search}%", "%#{search}%"])
        else
          all
        end
    end

end
