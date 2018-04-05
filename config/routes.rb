Rails.application.routes.draw do
	# Disable preconfigured routes in-favor of custom implementation
	#devise_for :users

	# Point at base url of front-end app
	#root to: "home#index

	resources :users
	
	namespace :api do
	  namespace :v1 do
	  	resources :sessions, only: [:create, :destroy]
	  end
	end

end
