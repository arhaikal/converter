require 'rails_helper'

RSpec.describe Exchange, :type => :model do


  let(:user) {User.create(email: 'user@example.com', password: 'password', id: 1)}


  subject {
    described_class.new(amount: 100, base_currency: "EUR",
                        target_currency: "USD", waiting_time: 2,
                        user_id: user.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an amount" do
    subject.amount = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a negative amount" do
    subject.amount = -12
    expect(subject).to_not be_valid
  end

  it "is not valid without a base_currency" do
    subject.base_currency = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a target_currency" do
    subject.target_currency = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a waiting_time" do
    subject.waiting_time = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a negative waiting_time" do
    subject.waiting_time = -12
    expect(subject).to_not be_valid
  end

  it "is not valid with waiting_time greater that 250" do
    subject.waiting_time = 251
    expect(subject).to_not be_valid
  end

end
