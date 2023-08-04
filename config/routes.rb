Rails.application.routes.draw do

	# Point at base url of front-end app
	#root to: "home#index

	devise_for :users, only: []
	resources :users
	
	namespace :api do
	  namespace :v1 do
	  	get 'sessions/' => 'sessions#show', as: :show_new_session
	  	post 'sessions/' => 'sessions#create', as: :new_session
	  	delete 'sessions/' => 'sessions#destroy', as: :delete_session
	  	
	  	get 'deck_infos/' => 'deck_infos#show', as: :show_deck_info
	  	post 'deck_infos/' => 'deck_infos#create', as: :new_deck_info
	  	patch 'deck_infos/' => 'deck_infos#update', as: :edit_deck_info
	  	delete 'deck_infos/' => 'deck_infos#destroy', as: :delete_deck_info

	  	get 'best_times/' => 'best_times#show', as: :show_best_time
	  	post 'best_times/' => 'best_times#create', as: :new_best_time

	  	get 'memory_palaces/' => 'memory_palaces#show', as: :show_memory_palace
	  	post 'memory_palaces/attach_image' => 'memory_palaces#attach_image', as: :attach_image_to_memory_palace
	  	patch 'memory_palaces/' => 'memory_palaces#update', as: :edit_memory_palace
	  	delete 'memory_palaces/' => 'memory_palaces#destroy', as: :delete_memory_palace
	  end
	end

end
