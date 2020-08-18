class Config < ApplicationRecord
	has_one_attached :logo

	validates_presence_of :desc

	validates_uniqueness_of :desc	 
	 
end
