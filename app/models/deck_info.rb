class DeckInfo < ApplicationRecord
	
	# Relations
	has_many :users
	has_many :cards

	def sorted_cards
		return nil unless self.cards

		(1..4).each.inject({}) do |suit_hash, suit|
			suit_hash[suit] = self.get_cards_of_suit(suit)
			suit_hash
		end
	end

	# Suit:Integer
	def get_cards_of_suit(suit)
		denoms = self.cards.where(suit: suit).order(:card_number).each.inject({}) do |denom_hash, card|
			denom_hash[card.card_number] = card
			denom_hash
		end

		# Initialize all fields here so the client doesn't have to extend observable
		# NOTE: Figure out nicer way to do this on client perhaps, mobx is overly sensitive with 
		# handling large object state...
		(2..14).each do |potential_denom|
			denoms[potential_denom] ||= {
				image_url: '',
				name: '',
				action1: '',
				action2: ''
			}
		end

		return denoms
	end
end

