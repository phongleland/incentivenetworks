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
  
  describe ".filter_by_consumer" do
    let(:consumer1) { FactoryGirl.create :consumer }
    let(:consumer2) { FactoryGirl.create :consumer }
    let(:consumer3) { FactoryGirl.create :consumer }
  
    before(:each) do
      @transaction1 = FactoryGirl.create :transaction, consumer_id: consumer1.id
      @transaction2 = FactoryGirl.create :transaction, consumer_id: consumer1.id
      @transaction3 = FactoryGirl.create :transaction, consumer_id: consumer1.id
      @transaction4 = FactoryGirl.create :transaction, consumer_id: consumer1.id
      @transaction5 = FactoryGirl.create :transaction, consumer_id: consumer1.id
    
      @transaction6 = FactoryGirl.create :transaction, consumer_id: consumer2.id
    
      @transaction7 = FactoryGirl.create :transaction, consumer_id: consumer3.id
      @transaction8 = FactoryGirl.create :transaction, consumer_id: consumer3.id
      @transaction9 = FactoryGirl.create :transaction, consumer_id: consumer3.id
      @transaction10 = FactoryGirl.create :transaction, consumer_id: consumer3.id
      @transaction11 = FactoryGirl.create :transaction, consumer_id: consumer3.id
      @transaction12 = FactoryGirl.create :transaction, consumer_id: consumer3.id
    end
  
    context "when a consumer_id is sent" do
      it "returns the matching transactions" do
        expect(Transaction.filter_by_consumer(consumer1.id)).to have(5).items
        expect(Transaction.filter_by_consumer(consumer2.id)).to have(1).items
        expect(Transaction.filter_by_consumer(consumer3.id)).to have(6).items
      end

      it "returns the products matching" do
        expect(Transaction.filter_by_consumer(consumer1.id)).to match_array([@transaction1, @transaction2, @transaction3, @transaction4, @transaction5])
        expect(Transaction.filter_by_consumer(consumer2.id)).to match_array([@transaction6])
        expect(Transaction.filter_by_consumer(consumer3.id)).to match_array([@transaction7, @transaction8, @transaction9, @transaction10, @transaction11, @transaction12])
      end
    end
  end
  
  describe ".search" do
    let(:merchant1) { FactoryGirl.create :merchant }
    let(:merchant2) { FactoryGirl.create :merchant }
    let(:merchant3) { FactoryGirl.create :merchant }
    let(:consumer1) { FactoryGirl.create :consumer }
    let(:consumer2) { FactoryGirl.create :consumer }
    let(:consumer3) { FactoryGirl.create :consumer }
    
    before(:each) do
      @transaction1 = FactoryGirl.create :transaction, consumer_id: consumer1.id, merchant_id: merchant3.id
      @transaction2 = FactoryGirl.create :transaction, consumer_id: consumer1.id, merchant_id: merchant2.id
      @transaction3 = FactoryGirl.create :transaction, consumer_id: consumer2.id, merchant_id: merchant3.id
      @transaction4 = FactoryGirl.create :transaction, consumer_id: consumer3.id, merchant_id: merchant1.id
      @transaction5 = FactoryGirl.create :transaction, consumer_id: consumer1.id, merchant_id: merchant3.id
    end
    
    context "when an empty hash is sent" do
      it "returns an empty array" do
        expect(Transaction.search({})).to be_empty
      end
    end

    context "when merchant3" do
      it "returns the matches" do
        search_hash = { merchant_id: merchant3.id }
        expect(Transaction.search(search_hash)).to match_array([@transaction1, @transaction3, @transaction5])
      end
    end
    
    context "when consumer1" do
      it "returns the matches" do
        search_hash = { consumer_id: consumer1.id }
        expect(Transaction.search(search_hash)).to match_array([@transaction1, @transaction2, @transaction5])
      end
    end

    context "when consumer1 and merchant3" do
      it "returns the matches transaction1 and transaction5" do
        search_hash = { consumer_id: consumer1.id, merchant_id: merchant3.id }
        expect(Transaction.search(search_hash)).to match_array([@transaction1, @transaction5]) 
      end
    end

    context "when consumer2 and merchant1" do
      it "returns an empty array for no matches" do
        search_hash = { consumer_id: consumer2.id, merchant_id: merchant1.id }
        expect(Transaction.search(search_hash)).to be_empty
      end
    end
    
    context "when transaction_ids is present" do
      it "returns the transactions from the ids" do
        search_hash = { transaction_ids: [@transaction1.id, @transaction4.id]}
        expect(Transaction.search(search_hash)).to match_array([@transaction1, @transaction4])
      end
    end
  end
  
end
