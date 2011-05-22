
class Ranking < ActiveRecord::Base
  belongs_to :dish
  belongs_to :venue
  belongs_to :user

  named_scope :recent, :order => "updated_at DESC", :limit => 3
  named_scope :by_dish, :order => "dish_id ASC"
  named_scope :by_rank, :order => "position ASC"
end
