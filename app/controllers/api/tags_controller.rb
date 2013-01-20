class Api::TagsController < Api::BaseController
	respond_to :json 
	# before_filter :verify_auth_token 

	# Return list of tags from one specific user
	def index 
		@tags_list = Tag.where('user_id=?', params[:user_id])
	end

	# Return the information of a specific tag
	def show
		@user = current_user
		render :json => @user.tags.all
	end

	# Update the fields of tag of a specific user. Pass in the tag_code.
	def update
		@user = current_user
		@tag = @user.tags.find_by_tag_id(params[:tag_id])
			if @tag.update_attributes(params[:tag])
				render :status => 200,
					:json => {
					status: 200,
					tag: @tag
		}
    end
 	end

 	# Destroy a tag with a specific tag_code
 	def destroy
 	end

 	# Create a new tag associated to the auth'd user with defined params.
 	def create
 		@user = User.find_by_id(4)
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

end