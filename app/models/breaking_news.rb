class BreakingNews < ActiveRecord::Base
  attr_accessible :content, :name, :title

validates :name, presence: true
validates :content, presence: true
validates :title, presence: true

end
