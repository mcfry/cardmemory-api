class Api::V1::BestTimesController < ApplicationController

	def show
		if user_signed_in?
			ordered_times = current_user.best_times.order('difficulty ASC').order('seconds ASC').group_by(&:difficulty)
			render json: ordered_times.as_json, status: :ok
		else
			head(:unauthorized)
		end
	end

	def create
		if user_signed_in? && best_times_params[:difficulty] && best_times_params[:seconds] && best_times_params[:mistakes]
			if best_times_params[:mistakes] < 3
				ordered_times = current_user.best_times.where(difficulty: best_times_params[:difficulty]).order('seconds DESC')
				# 5 is the limit
				last_beaten = nil
				if ordered_times.length > 4
					puts best_times_params[:seconds]
					ordered_times.each do |time|
						puts time.seconds
						if best_times_params[:seconds] < time.seconds
							last_beaten = time
						elsif best_times_params[:seconds] == time.seconds && best_times_params[:mistakes] < time.mistakes
							last_beaten = time
							break
						else
							break
						end
					end
				else
					BestTime.create(user_id: current_user.id, seconds: best_times_params[:seconds], 
						mistakes: best_times_params[:mistakes], difficulty: best_times_params[:difficulty])
				end

				puts last_beaten.inspect
				if !last_beaten.blank?
					last_beaten.delete
					BestTime.create(user_id: current_user.id, seconds: best_times_params[:seconds], 
						mistakes: best_times_params[:mistakes], difficulty: best_times_params[:difficulty])
				end
				

				head(:created)
			else
				head(:ok)
			end
		else
			head(:unauthorized)
		end
	end

	private

		def best_times_params
			params.permit(:seconds, :mistakes, :difficulty)
		end

end