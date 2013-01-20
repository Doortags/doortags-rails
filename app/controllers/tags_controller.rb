class TagsController < ApplicationController

	def index  
		@tag = Tags.all
	end

	def edit
		@tag = Tag.find_by_id(params[:id])
	end

	def update 
		@tag = Tag.find_by_id(params[:id])
		if @tag.update_attributes(params[:tag])
       flash[:success] = "Tag successfully updated!"
       redirect_to "user/#{current_user.id}"
     else
      render 'edit'
    end
	end

	def create
		@tag = current_user.tags.build(params[:tag])
		if @tag.save
			flash[:success] = "Tag created"
			redirect_to :back
		end 
	end

	def destroy 
		@tag = Tag.find_by_id(params[:id])
		@tag.destroy 
		redirect_to :back
	end

end