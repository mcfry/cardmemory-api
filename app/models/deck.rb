class Deck < ApplicationRecord

	# Relations
	has_many :cards
	belongs_to :user, optional: true
	belongs_to :deck_info, optional: false

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
				image_tx: nil,
				image_ty: nil,
				image_h: nil,
				image_w: nil,
				name: '',
				action1: '',
				action2: '',
				action2_tx: nil,
				action2_ty: nil,
				action2_h: nil,
				action2_w: nil
			}
		end

		return denoms
	end
	
end
