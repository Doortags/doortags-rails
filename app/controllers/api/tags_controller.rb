class Api::TagsController < Api::BaseController
	respond_to :json 
	# before_filter :verify_auth_token 

	def show
		@user = current_user
		render :json => @user.tags.all
	end

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

 	def destroy
 	end

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