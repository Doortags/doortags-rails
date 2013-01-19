class Api::AuthController < Api::BaseController
  before_filter :verify_auth_token, :only => [:destroy]

  # POST /api/auth
  # Parameters: email=:email&password=:password
  # Requires authorization: no
  def create
    email    = params[:email]
    password = params[:password]

    if email.nil? or password.nil?
      render_json_response(400, "Authorization requires an email and password")
      return
    end

    # email.downcase ? Is this correct?
    @user = User.find_by_email(email.downcase)

    if @user.nil?
      logger.info "User with #{email} was not found"
      render_json_response(401, "Email or password invalid")
      return
    end

    @user.ensure_authentication_token!

    if not @user.valid_password?(password)
      logger.info "User with #{email} did not provide correct password"
      render_json_response(401, "Email or password invalid")
      return
    end

    # And now...if everything is correct
    render :status => 200,
           :json => {
             status: 200,
             token: @user.authentication_token,
           }
  end

  # POST /api/auth/destroy
  # Requires authorization: yes
  def destroy
    @user.reset_authentication_token!
    render_json_response(200, "Token successfully removed")
  end
end
