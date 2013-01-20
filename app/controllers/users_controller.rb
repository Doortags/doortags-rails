class UsersController < ApplicationController
  before_filter :authenticate_user!

	def show
		@tag = current_user.tags.build
		@tags_list = current_user.tags
	end
	
end
