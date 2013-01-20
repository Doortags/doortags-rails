class TagsController < ApplicationController

	def index  
		@tag = Tags.alphabetical

		respond_to do |format|
      		format.html # index.html.erb
      		format.json { render json: @books }
    	end
  	end

	def show
		@tag = Tag.find(params[:id])

    	respond_to do |format|
      	format.html # show.html.erb
      	format.json { render json: @tag }
    	end
  	end

  	def new
    	@tag = Tag.new
    
    	respond_to do |format|
     		format.html # new.html.erb
      	format.json { render json: @tag }
    	end
  	end

  	def edit
  		@tags = Tags.find(params[:id])
  	end

	def edit
		@tag = Tag.find_by_id(params[:id])
	end

	def update 
		@tag = Tag.find_by_id(params[:id])
		if @tag.update_attributes(params[:tag])
       flash[:success] = "Tag successfully updated!"
       redirect_to user_path(current_user)
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