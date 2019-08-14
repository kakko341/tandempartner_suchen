class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :message
	
	validates :user_id, presence: true
	validates :message_id, presence: true
	validates :content, presence: true, length: { maximum: 255}
end
