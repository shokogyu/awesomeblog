class Relationship < ApplicationRecord
	belongs_to :follower, class_name: "User" # follower: column name id
	belongs_to :followed, class_name: "User"
end
