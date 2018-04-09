class User < ApplicationRecord
	# Enable simple token
	acts_as_token_authenticatable

	# Relations
	belongs_to :deck_info, optional: true

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable
end
