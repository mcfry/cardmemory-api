class Api::V1::DeckInfosController < ApplicationController

	def show
		if user_signed_in?
			if current_user.deck
				cards = current_user.deck.sorted_cards

				simple_object = Hash.new
				simple_object[:deck_info] = current_user.deck.deck_info
				simple_object[:cards] = cards.presence ? cards : {}

				render json: simple_object.as_json, status: :ok
			else
				head(:not_found)
			end
		else
			head(:unauthorized)
		end
	end

	def create
		if user_signed_in?
			deck_info = DeckInfo.where(deck_info_params).first
			deck_info ||= DeckInfo.create(deck_info_params)

			if !current_user.deck
				Deck.create(deck_info_id: deck_info.id, user_id: current_user.id)
			else
				head(:unauthorized)
			end

			head(:created)
		else
			head(:unauthorized)
		end
	end

	def update
		if user_signed_in?
			deck = current_user.deck
			if deck
				card_slots = deck.sorted_cards
				(1..4).each do |suit|
					(2..14).each do |denom|
						db_slot = card_slots[suit][denom]
						client_slot = params[:cards][suit.to_s][denom.to_s]

						if [:name, :image_url, :action1, :action2].any?{|field| db_slot[field] != client_slot[field]}
							new_hash = {
								suit: suit,
								card_number: denom,
								name: client_slot[:name],
								image_url: client_slot[:image_url],
								action1: client_slot[:action1],
								action2: client_slot[:action2]
							}

							existing = Card.where(deck_id: deck.id, suit: suit, card_number: denom).first
							if existing
								existing.update(new_hash)
							else
								new_card = Card.create(new_hash)
								new_card.deck_id = deck.id
								new_card.save
							end
						end
					end
				end

				head(:accepted)
			else
				head(:not_found)
			end
		else
			head(:unauthorized)
		end
	end

	def destroy

	end

	private

		def deck_info_params
			params.permit(:deck_type, :red, :black, :hearts, :diamonds, :clubs, :spades)
		end

		def card_params
			# Integer keys break strong params, do this manually
		end

end