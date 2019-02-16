class ApplicationController < ActionController::Base
	# https://api.rubyonrails.org/classes/ActionController/HttpAuthentication/Basic.html
	BASIC_AUTH_USERNAME = ENV['BASIC_AUTH_USERNAME'] || '1'
	BASIC_AUTH_PASSWORD = ENV['BASIC_AUTH_PASSWORD'] || '1'
	http_basic_authenticate_with name: BASIC_AUTH_USERNAME, password: BASIC_AUTH_PASSWORD
end
