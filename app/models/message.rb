class Message < ApplicationRecord
    belongs_to :user
        
    validates :content, presence: true, length: {maximum: 255}
    validates :title, presence: true, length: {maximum: 255}
    mount_uploader :photo, PhotoUploader
    validate :photo_size
    
    has_many :favorites, foreign_key: 'message_id', dependent: :destroy
    has_many :users, through: :favorites
    
    private
    
    def photo_size
      if photo.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    
end
