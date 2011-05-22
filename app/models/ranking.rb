
class Ranking < ActiveRecord::Base
	belongs_to :dish
	belongs_to :venue
	belongs_to :user

	named_scope :recent, :order => "updated_at DESC"
end
