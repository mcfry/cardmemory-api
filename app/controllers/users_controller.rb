class UsersController < ApplicationController

	def show
		user = User.where(id: params[:id]).first

		render json: user.as_json(only: [:username, :email]), status: :ok
	end

	def index
		users = User.all

		if users
			render json: users.as_json(only: [:username, :email]), status: :ok
		else
			render nothing: true, status: :no_content
		end
	end
	
	def create
		if User.where(short_user_params).empty?
			user = User.new(user_params)

			if user.save
				render json: user.as_json(only: [:username, :email, :authentication_token]), status: :created
			else
				head(:bad_request)
			end
		else
			head(:not_found)
		end
	end

	def update
		user = User.where(id: params[:id]).first
		user.update_attributes(user_params)
		user.save

		render json: user.as_json(only: [:username, :email, :authentication_token]), status: :ok
	end

	def destroy
		user = User.where(id: params[:id]).first

		if user.destroy
			head(:ok)
		else
			head(:unprocessable_entity)
		end
	end

	private

		def short_user_params
			params.permit(:username, :email)
		end

		def user_params
			params.permit(:username, :email, :password, :password_confirmation)
		end
end