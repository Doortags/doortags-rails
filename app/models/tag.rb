class Tag < ActiveRecord::Base
	belongs_to :user
  attr_accessible :location, :tag_code, :user_id
end
