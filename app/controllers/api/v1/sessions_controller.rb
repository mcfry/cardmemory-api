class Api::V1::SessionsController < ApplicationController

	# TODO: sign in/out and persist local storage on client
	def show
      current_user ? head(:ok) : head(:unauthorized)
    end
	
	def create
		user = User.where(username: params[:username]).first

		if user&.valid_password?(params[:password])
			render json: user.as_json(only: [:username, :email, :authentication_token]), status: :created
		else
			head(:unauthorized)
		end
	end

	def destroy
		current_user&.authentication_token = nil
		
        if current_user&.save
          head(:ok)
        else
          head(:unauthorized)
        end
	end

end