class MemoryPalace < ApplicationRecord

	serialize :groups_to_image_array, Array

	# Relations
	belongs_to :user, optional: true
	has_many_attached :images

	scope :with_eager_loaded_images, -> { eager_load(images_attachments: :blob) }

	# Validations
	attr_accessor :skip_name_validation
	validate :validate_name, on: :create, unless: :skip_name_validation
	before_destroy :validate_name
	around_destroy :purge_images

	def self.find_image_url(image)
		Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
	end

	def image_urls
		if self.images.attached?
			self.images.each.inject([]) do |urls, image|
				urls << MemoryPalace.find_image_url(image); urls
			end
		else
			nil
		end
	end

	private

		def purge_images
			images = self.images.attached? ? self.images : [];
			yield # yield and delete
			images.each do |image|
				puts "deleted #{image.filename}"
				image.purge
			end
		end

		def validate_name
			self.name != 'default'
		end

end
