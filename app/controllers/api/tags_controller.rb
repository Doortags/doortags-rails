class Api::TagsController < Api::BaseController
  respond_to :json 
  before_filter :verify_auth_token 

  # Pass in: the user_id of the user you want to see the tags of
  # Return: list of tags from one specific user
  # Route: /tags/
  def index 
    tags = @user.tags
    tags_list = []
    tags.find_each do |tag|
      tags_list << stringify_tag(tag)
    end

    render :status => 200,
      :json => {
        status: 200, 
        tags: tags_list
      }
  end

  # Pass in: specific tag_code
  # Returns: user, id, and location associated with tag_code
  # Route: /tags/:id
  def show
    tag = Tag.find_by_id(params[:id])

    if tag
      render :status => 200,
        :json => {
          status: 200, 
          user: tag.user.name,
          id: tag.id,
          location: tag.location 
        }
    else
      render_json_response(404, "No such tag_code")
    end
  end

  # Pass in: new location
  # Update: The location of the tag
  # Route: /tags/update/:id
  def update
    tag = @user.tags.find_by_id(params[:id])
    if tag
      if tag.update_attributes(location: params[:location])
        render_json_response(200, "Tag updated")
      else
        render_json_response(406, "Could not update tag")
      end
    else 
      render_json_response(404, "Tag not found")
    end
  end

  # Pass in: tag_code
  # Destroy: the tag associated with the tag_code
  # Route: /tags/:id
  def destroy
    tag = Tag.find_by_id(params[:id])
    if !tag
      render_json_response(404, "Could not find tag")
    end

    if tag.destroy
      render_json_response(200, "Removed tag successfully")
    else
      render_json_response(406, "Could not remove tag")
    end
  end

  # Pass in: tag parameters -- location and tag code
  # Create: a New tag associated to the auth'd user with defined params.
  # Route: post to /tags
  def create
    tag = @user.tags.build(:location => params[:location])

    if tag.save
      render :status => 200,
        :json => stringify_tag(tag)
    else 
      render_json_response(406, "Could not create tag")
    end
  end

  private
  def stringify_tag(tag)
    return {
      id: tag.id,
      location: tag.location
    }
  end
end
