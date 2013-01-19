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

	def create
		@tag = current_user.tags.build(params[:tag])
		if @tag.save
			flash[:success] = "Tag created"
			redirect_to "user/#{current_user.id}"
		end 
	end

	def update
		@tag = Tags.for_user(current_user).find(params[:id])
		if @book.update_attributes(params[:tag])
			format.html { redirect_to @tag, notice: 'Tag was succesfully updated.'}
			format.json {head :no_content }
		else
			format.html { render action: "edit" }
        	format.json { render json: @tag.errors, status: :unprocessable_entity }
      	end
     end



	def destroy
		@tag =  Tags.for_user(current_user).find(params[:id])
		if @tag.destroy
			flash[:success] = "Tag created"
			redirect_to "user/#{current_user.id}"
		end
	end


end