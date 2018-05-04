class User < ApplicationRecord

	attr_accessor :activation_token

	has_many :microposts, dependent: :destroy # the name of model + s
	
	has_many :active_relationships, class_name: "Relationship",
									foreign_key: "follower_id",
									dependent: :destroy
	has_many :following, 	through: :active_relationships,
							source: :followed #,class: "User",  teated array




	has_many :passive_relationships, class_name: "Relationship",
									foreign_key: "followed_id",
									dependent: :destroy
	has_many :followers, through: :passive_relationships




	before_save :downcase_email # callback method , new object and existing
	#before_save {email.downcase!} # code is directly written, dirty
	# before_save {self.email = email.downcase }
	before_create :create_activation_digest    # new object, not available when upadating

	validates :name,	presence: true,
						length: {maximum: 50}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,	presence: true,
						length: {maximum: 255},
						format: {with: VALID_EMAIL_REGEX},
						uniqueness: {case_sensitive: false}

	# bcrypt provide us this method		
	has_secure_password
		# checks for password and confirmation_password
		# it will hash the password data and store it to password_digest column
	validates :password, length: {minimum: 6}, allow_nil: true

	def feed
		#Micropost.where(user_id: id) # find_by -> return one, but where is different
		Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)
	end

	def follow(other_user)
		following << other_user # self.followingの意味
		#active_relationships.create(followed_id: other_user.id)		
	end

	def unfollow(other_user)
		following.delete(other_user)
		#active_relationships.find_by(followed_id: other_user.id).destroy		
	end

	def following?(other_user)
		following.include?(other_user)
	end

	def authenticate?(token)
		return false if activation_digest.nil?
		BCrypt::Password.new(activation_digest).is_password?(token)
	end



	private

	def downcase_email
		email.downcase!
	end

	def create_activation_digest
	    self.activation_token = SecureRandom.urlsafe_base64

	    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
	    self.activation_digest = BCrypt::Password.create(self.activation_token, cost: cost)
	end


end
