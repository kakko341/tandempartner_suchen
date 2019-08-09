class Message < ApplicationRecord
    belongs_to :user
    has_many_attached :images
        
    validates :content, presence: true, length: {maximum: 255}
    validates :title, presence: true, length: {maximum: 255}
    mount_uploader :photo, PhotoUploader
    validate :photo_size
    
    has_many :favorites, foreign_key: 'message_id', dependent: :destroy
    has_many :users, through: :favorites
    
<<<<<<< HEAD
    def self.search(search)
        if search
          where(["title LIKE? or content LIKE?", "%#{search}%", "%#{search}%"])
        else
          all
        end
    end

=======
    private
    
    def photo_size
      if photo.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    
>>>>>>> 72aa981102d525f0f93f0c887601db612ffc8fc3
end
