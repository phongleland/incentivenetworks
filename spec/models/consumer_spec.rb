require 'rails_helper'

RSpec.describe Consumer, type: :model do
  
  let(:consumer) { FactoryGirl.build :consumer }
  subject { consumer }

  it { should respond_to(:firstname) }
  it { should respond_to(:lastname) }
  
  it { should validate_presence_of :firstname }
  it { should validate_presence_of :lastname }
    
  it { should have_many(:transactions) }
end
