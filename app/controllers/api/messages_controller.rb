class Api::MessagesController < Api::BaseController


  # Pass in: tag_code. Message and name are optional
  # Sends message to user with said tag_code
	def send_message_to
		message = params[:message]
    tag_id = params[:tag_id]
    name = params[:name]

    user = Tag.find_by_id(tag_id).user
    number_to_send_to = user.phone
    location = Tag.find_by_id(tag_id).location
 
    twilio_sid          = APP_CONFIG["twilio"]["sid"]
    twilio_token        = APP_CONFIG["twilio"]["token"]
    twilio_phone_number = APP_CONFIG["twilio"]["number"]

    if name.nil?
      name = "someone"
    end

    if message.nil?
      message = "nothing..."
    end

    body = "#{name} rang your doorbell at #{location}: \"#{message}\""

    unless user.nil?
      @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
   
      @twilio_client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => number_to_send_to,
        :body => body
      )	

      render :json => {
        itworks!: "hello"
      }

    else 

      render :json => {
        sadface: "Sadly, it didn't work"
      }
    end

	end
end
