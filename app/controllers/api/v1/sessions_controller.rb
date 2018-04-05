class Api::V1::SessionsController < ApplicationController
	
	def create
		user = User.where(username: params[:username]).first

		if user&.valid_password?(params[:password])
			render json: user.as_json(only: [:username, :email, :authentication_token]), status: :created
		else
			head(:unauthorized)
		end
	end

	def destroy
		
	end

end