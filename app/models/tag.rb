class Tag < ActiveRecord::Base
	belongs_to :user
  attr_accessible :location
end
