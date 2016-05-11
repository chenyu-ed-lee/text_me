class TextsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def create
		account_sid = Rails.application.secrets.twilio_account_sid
		auth_token = Rails.application.secrets.twilio_auth_token
		
		client = Twilio::REST::Client.new(account_sid, auth_token)
		user = User.find(params[:user_id])
		flash[:success] = "Text sent successfully!"
		message = client.account.messages.create(
			:from => '+16506845087',
			:to => '+1' + params[:to],
			:body => 'Hey ' + params[:name] + ', ' + params[:message] + ' -Sent from TextMe-'
			)
		redirect_to "/users/#{user.id}"
	end
end
