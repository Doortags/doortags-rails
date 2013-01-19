class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  # Render a JSON status response
  def render_json_response(status, message, more={})
    json = {
      status: status,
      msg: message
    }
    json.merge!(more)

    render :status => status, :json => json
  end
end
