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
  
  def self.search(params = {})

    return Transaction.none if (params.keys & [:transaction_ids, :merchant_id, :consumer_id]).empty?
    
    transactions = params[:transaction_ids].present? ? Transaction.find(params[:transaction_ids]) : Transaction.all
    transactions = transactions.filter_by_merchant(params[:merchant_id]) if params[:merchant_id]
    transactions = transactions.filter_by_consumer(params[:consumer_id]) if params[:consumer_id]
    transactions
  end
end
