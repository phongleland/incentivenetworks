class Consumer < ActiveRecord::Base
  validates :firstname, :lastname, presence: true
  
  has_many :transactions, dependent: :destroy
end
