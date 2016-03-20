class Consumer < ActiveRecord::Base
  validates :firstname, :lastname, presence: true
end
