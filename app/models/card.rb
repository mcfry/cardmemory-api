class Card < ApplicationRecord
	
	# Relations
	belongs_to :deck

	# Validations
	validate :validate_quota, on: :create

	# Number of cards
	LIMIT = 52

	def validate_quota
		return unless self.deck
		if self.deck.cards.count >= LIMIT
			errors.add(:base, :exceeded_quota)
		end
	end

end