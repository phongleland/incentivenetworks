class Merchant < ActiveRecord::Base
  validates :name, :domain, presence: true
end
