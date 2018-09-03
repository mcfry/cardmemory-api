class MemoryPalace < ApplicationRecord

	# Relations
	belongs_to :user
	has_many_attached :images

end
