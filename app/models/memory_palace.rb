class MemoryPalace < ApplicationRecord

	# Relations
	belongs_to :user, optional: true
	has_many_attached :images

	# Validations
	attr_accessor :skip_name_validation
	validate :validate_name, on: :create, unless: :skip_name_validation

	def image_urls
		if self.images.attached?
			self.images.each.inject([]) do |urls, image|
				urls << Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true); urls
			end
		else
			nil
		end
	end

	private

		def validate_name
			self.name != 'default'
		end

end
