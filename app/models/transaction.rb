class Transaction < ActiveRecord::Base
  validates :sale_date, :consumer_id, :merchant_id, presence: true
  validates :sale_amount, numericality: { greater_than_or_equal_to: 0 },
                      presence: true
                      
  belongs_to :consumer
  belongs_to :merchant
  
  scope :filter_by_merchant, lambda { |merchant_id|
    where("merchant_id = ?", merchant_id ) 
  }
  scope :filter_by_consumer, lambda { |consumer_id|
    where("consumer_id = ?", consumer_id ) 
  }
end
