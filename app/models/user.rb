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

	# Callback
	after_create :create_default_memory_palace

	def create_default_memory_palace
		mp = MemoryPalace.new(user_id: self.id, name: 'default')
		mp.skip_name_validation = true
		(1..5).each do |default_num|
			mp.images.attach(io: File.open(Rails.root.join("storage", "mem_palace_default", "panodefault#{default_num}.jpg")), filename: "panodefault#{default_num}.jpg", content_type: "image/jpg")
		end
		mp.save
	end

	def available_memory_palaces
		out = MemoryPalace.where(user_id: self.id).with_eager_loaded_images
		out.length > 0 ? out : nil
	end

end
