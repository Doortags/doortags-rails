class Api::TagsController < Api::BaseController
	respond_to :json 
	before_filter :verify_auth_token 

	def show
		render :json => Tag.all 
	end

	def update
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
 	end

end