# frozen_string_literal: true

require './lib/account'
require 'date'

describe Account do
  let(:account) { Account.new(owner: person) }

  let(:person) { instance_double('Person', name: 'Fahad') }
  subject { described_class.new({ owner: person }) }

  it 'consist of 4 digit pin code' do
    number = rand(1000..9999)
    Math.log10(number).to_i
    expect(number.digits.count).to eq 4
  end

  it 'needs an expiry date on initialize ( 5years )' do
    expected_date = Date.today.next_year(5).strftime('%m/%y')
    expect(account.set_expire_date).to eq expected_date
  end

  it 'is expected to have :active status on initialize' do
    expect(subject.account_status).to eq :active
  end

  it 'deactivates account using instance method' do
    subject.deactivate
    expect(subject.account_status).to eq :deactivated
  end

  it 'is expected to have an owner' do
    expect(subject.owner).to eq person
  end

  it 'is expected to raise error if no owner is set' do
    expect { described_class.new }.to raise_error 'An Account owner is required'
  end



  # Used for deactiving multiple accounts
  # it "deactivates account using class method" do
  #   Account.deactivated(subject)
  #   expect(subject.account_status).to eq :deactivated
  # end
end
