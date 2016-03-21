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
  
  describe ".filter_by_merchant" do
    let(:merchant1) { FactoryGirl.create :merchant }
    let(:merchant2) { FactoryGirl.create :merchant }
    let(:merchant3) { FactoryGirl.create :merchant }
    
    before(:each) do
      @transaction1 = FactoryGirl.create :transaction, merchant_id: merchant1.id
      @transaction2 = FactoryGirl.create :transaction, merchant_id: merchant1.id
      
      @transaction3 = FactoryGirl.create :transaction, merchant_id: merchant2.id
      @transaction4 = FactoryGirl.create :transaction, merchant_id: merchant2.id
      @transaction5 = FactoryGirl.create :transaction, merchant_id: merchant2.id
      @transaction6 = FactoryGirl.create :transaction, merchant_id: merchant2.id
      
      @transaction7 = FactoryGirl.create :transaction, merchant_id: merchant3.id
      @transaction8 = FactoryGirl.create :transaction, merchant_id: merchant3.id
      @transaction9 = FactoryGirl.create :transaction, merchant_id: merchant3.id
    end
    
    context "when a merchant_id is sent" do
      it "returns the matching transactions" do
        expect(Transaction.filter_by_merchant(merchant1.id)).to have(2).items
        expect(Transaction.filter_by_merchant(merchant2.id)).to have(4).items
        expect(Transaction.filter_by_merchant(merchant3.id)).to have(3).items
      end

      it "returns the products matching" do
        expect(Transaction.filter_by_merchant(merchant1.id)).to match_array([@transaction1, @transaction2])
        expect(Transaction.filter_by_merchant(merchant2.id)).to match_array([@transaction3, @transaction4, @transaction5, @transaction6])
        expect(Transaction.filter_by_merchant(merchant3.id)).to match_array([@transaction7, @transaction8, @transaction9])
      end
    end
    
  end
  
end
