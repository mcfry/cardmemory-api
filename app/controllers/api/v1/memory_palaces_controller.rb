class Api::V1::MemoryPalacesController < ApplicationController

	def show
		if user_signed_in?
			if current_user.available_memory_palaces
				palaces = current_user.available_memory_palaces

				simple_object = palaces.inject({}) do |obj, palace|
					palObj = Hash.new
					palObj['image_urls'] = palace.image_urls
					palObj['groups_to_image_array'] = palace.groups_to_image_array
					obj[palace.name] = palObj

					next obj
				end

				render json: simple_object.as_json, status: :ok
			else
				head(:not_found)
			end
		else
			head(:unauthorized)
		end
	end

	def update
		if user_signed_in?
			if mem_palace_params[:name]
				mem_pal = MemoryPalace.where(user_id: current_user.id, name: mem_palace_params[:name]).first
				if !mem_pal.blank?
					mem_pal.groups_to_image_array = full_params[:groups_to_image_array]

					# Do it here rather than as a seperate method/endpoint to reduce the #requests
					# Remove/delete any images if removed from palace
					image_url_hash = mem_palace_params[:image_urls].inject(Hash.new){|h, url| h[url] ||= true; h}
					mem_pal.images.each do |image_attachment|
						image_attachment.purge if !image_url_hash[MemoryPalace.find_image_url(image_attachment)]
					end

					mem_pal.save
				else
					head(:bad_request)
				end
			else
				head(:bad_request)
			end

			head(:ok)
		else
			head(:unauthorized)
		end
	end

	# def create_memory_palace(user, pal_name, groups_to_image_array = [], image_urls = [])
	# 	if user && pal_name && groups_to_image_array.kind_of?(Array) && image_urls.kind_of?(Array)
	# 		if MemoryPalace.where(user_id: user.id, name: pal_name).blank?
				
	# 				render json: {
	# 					message: "The word 'default' is a reserved name for Memory Palaces, please choose another."
	# 				}.to_json, status: :unauthorized
	# 			end
	# 		else
	# 			render json: {
	# 				message: "A memory palace already exists with that name."
	# 			}.to_json, status: :unauthorized
	# 		end
	# 	else
	# 		head(:bad_request)
	# 	end
	# end

	def attach_image
		if user_signed_in?
			mem_pal = MemoryPalace.where(user_id: current_user.id, name: attach_image_params[:name])
			if mem_pal.blank?
				head(:bad_request)
			else
				if attach_image_params[:signed_id].presence
					mem_pal.attach(attach_image_params[:signed_id])
					head(:ok)
				else
					head(:bad_request)
				end
			end
		else
			head(:unauthorized)
		end
	end

	# todo
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
				}.to_json, status: :bad_request
			end
		else
			head(:unauthorized)
		end
	end

	private

		# Note, nested arrays are not supported by strong params. Just use whitelisted params.
		def mem_palace_params
			params.permit(:name, image_urls: [])
		end

		def full_params
			params.permit!
		end

		def attach_image_params
			params.permit(:name, :signed_id)
		end

end