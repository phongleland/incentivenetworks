require 'rails_helper'

RSpec.describe Consumer, type: :model do
  
  before { @consumer = FactoryGirl.build(:consumer) }
  subject { @consumer }

  it { should respond_to(:firstname) }
  it { should respond_to(:lastname) }
  
  it { should validate_presence_of :firstname }
  it { should validate_presence_of :lastname }
    
  it { should have_many(:transactions) }
  
  describe "#transactions association" do

    before do
      @consumer.save
      merchant = FactoryGirl.create(:merchant)
      3.times { FactoryGirl.create :transaction, {consumer: @consumer, merchant: merchant} }
    end

    it "destroys the associated transactions on self destruct" do
      transactions = @consumer.transactions
      @consumer.destroy
      transactions.each do |transaction|
        expect(Transaction.find(transaction)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
    
end
