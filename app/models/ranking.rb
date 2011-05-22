
class Ranking < ActiveRecord::Base
	belongs_to :dish
	belongs_to :venue
	belongs_to :user
end