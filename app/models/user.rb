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

	# AR Callbacks
	attr_accessor :default_mem_palace_ref
	after_create :set_default_memory_palace

	def available_memory_palaces
		out = []
		out << self.default_mem_palace_ref if self.default_mem_palace_ref
		out << MemoryPalace.where(user_id: self.id)
		return out
	end

	private

		def set_default_memory_palace
			self.default_mem_palace_ref = MemoryPalace.where(name: 'default')
		end
end
