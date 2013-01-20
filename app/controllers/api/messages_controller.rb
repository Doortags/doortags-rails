class Api::MessagesController < Api::BaseController


  # Pass in: tag_code. Message and name are optional
  # Sends message to user with said tag_code
	def send_message_to
		message = params[:message]
    tag_code = params[:tag_code]
    name = params[:name]

    unless name?
      name = "someone"
    end

    unless message?
      message = "I didn't send a message!"
    end

    user = Tag.find_by_tag_code(tag_code).user
    number_to_send_to = user.phone
    location = Tag.find_by_tag_code(tag_code).location
 
    twilio_sid = "ACfffe2a378d744f6c9c2a280c93a5be21"
    twilio_token = "374dca84e42fc9ca7f67319cb58b601a"
    twilio_phone_number = "2674158802"


    if user?
      @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
   
      @twilio_client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => number_to_send_to,
        :body => "Hey, #{name} is at your #{location} and he says \"#{message}\""
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
