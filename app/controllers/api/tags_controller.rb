class Api::TagsController < Api::BaseController
	respond_to :json 

	def show
		render :json => Tag.all 
	end

	def update
		@tag = Tag.find_by_tag_id(params[:tag_id])
			if @tag.update_attributes(params[:tag])
				render :status => 200,
					:json => {
					status: 200,
					tag: @tag
		}
    end
 	end

end