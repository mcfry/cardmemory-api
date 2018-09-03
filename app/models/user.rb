class User < ApplicationRecord
	# Enable simple token
	acts_as_token_authenticatable

	# Relations
	has_one :deck
	has_many :best_times
	has_many :memory_palaces

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable
end
