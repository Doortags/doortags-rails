class TagsController < ApplicationController

	def index  
		@tag = Tags.all
	end

	def create
		@tag = current_user.tags.build(params[:tag])
		if @tag.save
			flash[:success] = "Tag created"
			redirect_to "user/#{current_user.id}"
		end 
	end

	def destroy 
	end

end