require 'rails_helper'

RSpec.describe Merchant, type: :model do
  
  let(:merchant) { FactoryGirl.build :merchant }
  subject { merchant }

  it { should respond_to(:name ) }
  it { should respond_to(:domain ) }
  
  it { should validate_presence_of :name }
  it { should validate_presence_of :domain }
  
  it { should have_many(:transactions) }
  
end
