require 'rails_helper'

RSpec.describe Merchant, type: :model do
  
  before { @merchant = FactoryGirl.build(:merchant) }
  subject { @merchant }

  it { should respond_to(:name ) }
  it { should respond_to(:domain ) }
  
  it { should validate_presence_of :name }
  it { should validate_presence_of :domain }
  
  it { should have_many(:transactions) }
  
  describe "#transactions association" do

    before do
      @merchant.save
      consumer = FactoryGirl.create(:consumer)
      3.times { FactoryGirl.create :transaction, {consumer: consumer, merchant: @merchant} }
    end

    it "destroys the associated transactions on self destruct" do
      transactions = @merchant.transactions
      @merchant.destroy
      transactions.each do |transaction|
        expect(Transaction.find(transaction)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
  
end
