class Merchant < ActiveRecord::Base
  validates :name, :domain, presence: true
  
  has_many :transactions, dependent: :destroy
end
