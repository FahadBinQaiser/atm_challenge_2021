require "./lib/atm.rb"
require 'date'

describe Atm do
  let(:account) { instance_double('Account', pin_code: '1234', exp_date:'12/26', account_status: :active) }
  before do
    allow(account).to receive(:balance).and_return(100)
    allow(account).to receive(:balance=) 
  end
  it "allow withdraw if the account has enough balance." do
    expected_output = { status: true, message: 'success', date: Date.today, amount: 45 }
    expect(subject.withdraw(45, '1234', account, :disabled)).to eq expected_output
  end
  it "has 1000$ on initialize" do
    expect(subject.funds).to eq 1000
  end 
  it "funds are reduced at withdraw" do
    subject.withdraw(100, '1234', account, :disabled)
    expect(subject.funds).to eq 900
  end 
  it "reject withdraw if account has insufficient funds" do
    expected_output = { status: false, message: 'insufficient funds', date: Date.today }
    expect(subject.withdraw(105, '1234', account, :disabled)).to eq expected_output
  end
  it "reject withdraw if ATM has insufficient funds" do
    subject.funds = 50
    expected_output = { status: false, message: 'insufficient funds in ATM', date: Date.today }
    expect(subject.withdraw(100, '1234', account, :disabled)).to eq expected_output
  end
  it "reject withdraw if pin is wrong" do
    expected_output = {status:false, message: 'wrong pin', date: Date.today}
    expect(subject.withdraw(50,'9999', account, :disabled)).to eq expected_output
  end
  it "reject withdraw if the card is expired" do 
    allow(account).to receive(:exp_date).and_return('12/18')
    expected_output = {status:false, message: 'card expired', date: Date.today}
    expect(subject.withdraw(6, '1234', account, :disabled)).to eq expected_output
  end
  it "if account is disabled" do
    allow(account).to receive(:account_status).and_return(:active)
    expected_output = {status:false, message: 'account disabled', date:Date.today}
    expect(subject.withdraw(50, '1234', account, :active)).to eq expected_output
  end
end

