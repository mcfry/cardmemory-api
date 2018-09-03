class Api::V1::SessionsController < ApplicationController

	def show
		current_user ? head(:ok) : head(:unauthorized)
    end
	
	def create
		user = User.where(username: params[:username]).first

		if user&.valid_password?(params[:password])
			render json: user.as_json(only: [:username, :email, :authentication_token]), status: :created
		else
			render json: {
				message: "User doesn't exist or the password provided is incorrect."
			}.to_json, status: :unauthorized
		end
	end

	def destroy
		current_user&.authentication_token = nil

        if current_user&.save
			head(:ok)
        else
			render json: {
				message: 'Unable to logout.'
			}.to_json, status: :unauthorized
        end
	end

end