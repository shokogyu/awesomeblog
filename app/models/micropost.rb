class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)} # lamda
  mount_uploader :picture, PictureUploader  # carrier wave
  validates	:user_id, presence: true
  validates	:content, presence: true, length: { maximum: 140 }
  validate :picture_size

  private
  
	def picture_size
	 if picture.size > 5.megabytes # size = carrier wave provides us method
	    errors.add(:picture, "should be less than 5MB") 
   end
	end
end