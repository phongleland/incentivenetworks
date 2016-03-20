require 'rails_helper'

RSpec.describe Transaction, type: :model do
  
  let(:transaction) { FactoryGirl.build :transaction }
  subject{transaction}
  
  it { should validate_presence_of :sale_date }
  it { should validate_presence_of :sale_amount }
  it { should validate_numericality_of(:sale_amount).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :merchant_id }
  it { should validate_presence_of :consumer_id }
  
  it { should belong_to :consumer }
  it { should belong_to :merchant }
end
