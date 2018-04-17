class Card < ApplicationRecord
	
	# Relations
	belongs_to :deck_info

	# Validations
	validate :validate_quota, on: :create

	# Number of cards
	LIMIT = 52

	def validate_quota
		return unless self.deck_info
		if self.deck_info.cards.count >= LIMIT
			errors.add(:base, :exceeded_quota)
		end
	end

end