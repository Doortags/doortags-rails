class Api::TagsController < Api::BaseController
	respond_to :json 
	# before_filter :verify_auth_token 

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
			render :status => 404, 
				:json => {
					status: 404, 
					sadface: "yes"
				}
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
			render :status => 404, 
				:json => {
					status: 404, 
					sadface: "yes"
				}
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
			render :status => 404, 
				:json => {
					status: 404, 
					sadface: "yes"
				}
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
				render :status => 404, 
					:json => {
						status: 404, 
						sadface: "yes"
					}
			end
    end
 	end

 	# Pass in: tag_code
 	# Destroy: the tag associated with the tag_code
 	# Route: /tags/(:tag_code)
 	def destroy
 		@tag = Tag.find_by_tag_code(params[:tag_code])
 		@tag.destroy
 	end

 	# Pass in: tag parameters -- location and tag code
 	# Create: a New tag associated to the auth'd user with defined params.
 	# Route: post to /tags
 	def create
 		@user = User.find_by_id(10) #This is just for testing so far
 		@tag = @user.tags.build(params[:tag])
 		if @tag.save
 			render :status => 200,
					:json => {
					status: 200,
					tag: @tag
		}
		else 
			render :status => 406,
						:json => {
						status: 406,
						failure: yes
			}
	 	end

 end
