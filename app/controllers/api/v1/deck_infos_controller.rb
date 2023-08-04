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

						if [:name, :image_url, :image_tx, :image_ty,
							:image_h, :image_w, :action1, :action2,
							:action2_tx, :action2_ty, :action2_h, :action2_w].any?{|field| db_slot[field] != client_slot[field]}
							
							new_hash = {
								suit: suit,
								card_number: denom,
								name: client_slot[:name],
								image_tx: client_slot[:image_tx],
								image_ty: client_slot[:image_ty],
								image_h: client_slot[:image_h],
								image_w: client_slot[:image_w],
								image_url: client_slot[:image_url],
								action1: client_slot[:action1],
								action2: client_slot[:action2],
								action2_tx: client_slot[:action2_tx],
								action2_ty: client_slot[:action2_ty],
								action2_h: client_slot[:action2_h],
								action2_w: client_slot[:action2_w]
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

				head(:ok)
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