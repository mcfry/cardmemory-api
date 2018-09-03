class Api::V1::MemoryPalacesController < ApplicationController

	def show
		if user_signed_in?
			if current_user.available_memory_palaces
				palaces = current_user.available_memory_palaces

				simple_array = palaces.each.inject([]) do |arr, palace|
					simple_object = Hash.new
					simple_object[:name] = palace.name
					simple_object[:images] = palace.image_urls
					arr << simple_object; arr
				end

				render json: simple_array.as_json, status: :ok
			else
				head(:not_found)
			end
		else
			head(:unauthorized)
		end
	end

	def create
		if user_signed_in?
			if MemoryPalace.where(user_id: current_user.id, name: mem_palace_params[:name]).blank?
				if !MemoryPalace.create(user_id: current_user.id, name: mem_palace_params[:name]).blank?
					head(:created)
				else
					render json: {
						message: "The word 'default' is a reserved name for Memory Palaces, please choose another."
					}.to_json, status: :unauthorized
				end
			else
				render json: {
					message: "A memory palace already exists with that name."
				}.to_json, status: :unauthorized
			end
		else
			head(:unauthorized)
		end
	end

	def attach_image
	end

	def destroy
		if user_signed_in?
			if !MemoryPalace.where(user_id: current_user.id, name: mem_palace_params[:name]).blank?
				if MemoryPalace.destroy(user_id: current_user.id, name: mem_palace_params[:name])
					render json: {}, status: :no_content
				else
					render json: {
						message: "Deleting the default memory palace is not allowed."
					}.to_json, status: :unauthorized
				end
			else
				render json: {
					message: "No memory palace exists with that name."
				}.to_json, status: :unauthorized
			end
		else
			head(:unauthorized)
		end
	end

	private

		def mem_palace_params
			params.permit(:name, :mem_palaces)
		end

end