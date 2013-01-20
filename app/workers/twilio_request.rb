class TwilioRequest
  @queue = :twilio_queue
  def self.perform(user_id, tag_id, message, name)
  	user = User.find(user_id)
  	number_to_send_to = user.phone
    location = Tag.find_by_id(tag_id).location


  	account_sid = "ACe6eee82649316e9f918b80e7ed1a8693"
  	auth_token = "f3cab3ce0871d20393d7a3cf37b1517b"
  	@twilio_client = Twilio::REST::Client.new account_sid, auth_token
  	twilio_phone_number = "4848213139"


  	client.account.sms.messages.create(
  		:from => "+1#{twilio_phone_number}",
  		:to => number_to_send_to,
  		:body => "Hey, #{name} is at your #{location} and he says \"#{message}\"
  	)
  end
end
