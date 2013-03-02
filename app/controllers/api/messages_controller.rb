class Api::MessagesController < Api::BaseController


  # Pass in: tag_code. Message and name are optional
  # Sends message to user with said tag_code
  def send_message_to
    tag_id      = params[:tag_id]
    sender_name = params[:name]
    message     = params[:message]
    Resque.enqueue(TwilioRequest, tag_id, sender_name, message)
  end
end
