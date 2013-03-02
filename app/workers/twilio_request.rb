class TwilioRequest
  @queue = :twilio_queue
  SMS_LIMIT = 140

  def self.perform(tag_id, name, message)
    tag  = Tag.find(tag_id)
    user = tag.user
    location = tag.location

    account_sid = APP_CONFIG[:twilio][:sid]
    auth_token  = APP_CONFIG[:twilio][:token]
    from        = APP_CONFIG[:twilio][:number]

    sms_text = truncate(
      "#{name} range your doorbell at #{location}: \"#{message}",
      :length => SMS_LIMIT - 1    # make space for ending quote
    )
    sms_text << "\""

    client = Twilio::REST::Client.new account_sid, auth_token
    client.account.sms.messages.create(
      :from => name,
      :to => user.phone,
      :body => sms_text
    )
  end
end
