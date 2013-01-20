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

    if name.nil?
      name = "someone"
    end

    if message.nil?
      message = "nothing..."
    end

    unless user.nil?
      Resque.enqueue(TwilioRequest, user.id, tag_id, message, name)
      
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
