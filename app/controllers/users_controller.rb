class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@tag = current_user.tags.build
		@tags_list = current_user.tags
	end
	
end
