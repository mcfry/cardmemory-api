class ApplicationController < ActionController::API
	acts_as_token_authentication_handler_for User, fallback: :none

	private

		# Hook/Callback
		def after_successful_token_authentication
	    end
end
