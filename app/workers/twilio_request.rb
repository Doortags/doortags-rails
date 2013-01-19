class TwilioRequest
  @queue = :twilio_queue
  def self.perform(user_id, tag_id, message, sender_number, name)
  	user = User.find(user_id)
  	tag = Tag.find(tag_id)

  	account_sid = "ACe6eee82649316e9f918b80e7ed1a8693"
  	auth_token = "f3cab3ce0871d20393d7a3cf37b1517b"
  	client = Twilio::REST::Client.new account_sid, auth_token
  	from = "+14848213139"

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
