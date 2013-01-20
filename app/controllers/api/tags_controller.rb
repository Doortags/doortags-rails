class Api::TagsController < Api::BaseController
<<<<<<< HEAD
  respond_to :json 
  before_filter :verify_auth_token 

  # Pass in: the user_id of the user you want to see the tags of
  # Return: list of tags from one specific user
  # Route: /tags/(:user_id)
  def index 
    @tags_list = Tag.where('user_id=?', params[:user_id])
    if @tags_list != nil
      render :status => 200,
        :json => {
          status: 200, 
          tags: @tags_list
        }
    else 
      render_json_response(404, "no such user_id")
    end
  end

  # Pass in: specific tag_code
  # Returns: user, id, and location associated with tag_code
  # Route: /tags/show_by_code/(:tag_code)
  def show_by_code
    @tag = Tag.find_by_tag_code(params[:tag_code])
    if @tag != nil 
      render :status => 200,
        :json => {
          status: 200, 
          user: User.find_by_id(@tag.user_id),
          id: @tag.id,
          location: @tag.location 
        }
    else 
      render_json_response(404, "No such tag_code")
    end
  end

  # Pass in: specific tag id
  # Returns: user, tag code, location associated with specific tag id
  # Route: /tags/show_by_id/(:id)
  def show_by_id
    @tag = Tag.find_by_id(params[:id])
    if @tag != nil && User.find_by_id(@tag.user_id) != nil
      render :status => 200,
        :json => {
          status: 200, 
          user: User.find_by_id(@tag.user_id).name,
          tag_code: @tag.tag_code,
          location: @tag.location 
        }
    else 
      render_json_response(404, "update failed")
    end
  end

  # Pass in: tag_code and new location
  # Update: The location of the tag
  # Route: /tags/update/(:tag_code)
  def update
    @user = current_user
    @tag = @user.tags.find_by_tag_code(params[:tag_code])
      if @tag.update_attributes(location: params[:location])
        render :status => 200,
          :json => {
            status: 200,
            tag: @tag
          }
      else 
        render_json_response(404, "Tag not found")
      end
  end

  # Pass in: tag_code
  # Destroy: the tag associated with the tag_code
  # Route: /tags/(:tag_code)
  def destroy
    @tag = Tag.find_by_tag_code(params[:tag_code])
    if @tag.destroy
      render_json_response(200, "Removed tag successfully")
    else
      render_json_response(404, "Could not find tag")
    end
  end

  # Pass in: tag parameters -- location and tag code
  # Create: a New tag associated to the auth'd user with defined params.
  # Route: post to /tags
  def create
    @tag = @user.tags.build(:location => params[:location])

    if @tag.save
      render :status => 200,
        :json => {
          status: 200,
          id: @tag.id,
          location: @tag.location
        }
    else 
      render_json_response(406, "Could not create tag")
    end
  end
end
