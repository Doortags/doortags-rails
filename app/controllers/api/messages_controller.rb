class Api::MessagesController < Api::BaseController

	def send_message_to
		number_to_send_to = params[:number_to_send_to]
		message = params[:message]
 
    twilio_sid = "INSERT HERE"
    twilio_token = "INSERT HERE"
    twilio_phone_number = "2674158802"
 
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
 
    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => message
    )	
	end

end