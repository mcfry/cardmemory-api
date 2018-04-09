class Api::V1::DeckInfosController < ApplicationController

	def create
		if user_signed_in?
			deck_info = DeckInfo.where(deck_info_params).first
			deck_info ||= DeckInfo.create(deck_info_params)

			render nothing: true, status: :created
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

end