class TwilioRequest
  @queue = :twilio_queue
  def self.perform(user_id, tag_id, message, sender_number, name)
  	user = User.find(user_id)
  	tag = Tag.find(tag_id)

  	account_sid = APP_CONFIG["twilio"]["sid"]
  	auth_token  = APP_CONFIG["twilio"]["token"]
  	from        = APP_CONFIG["twilio"]["number"]
  	client = Twilio::REST::Client.new account_sid, auth_token

  	number = ""
  	if sender_number
  		number =  " from phone number #{sender_number}"
  	end

  	client.account.sms.messages.create(
  		:from => from,
  		:to => user.phone,
  		:body => "#{name} left message at #{tag.location}#{number}. Message: #{message}"
  	)
  end
end
