require './lib/atm.rb'
require './lib/person.rb'

describe Person do
  subject{described_class.new(name: 'Fahad')}

  it 'is expected to have a :name on initialize' do
    expect(subject.name).not_to be nil
  end

  it 'is expected to raise an error if no name is set' do
    expect{described_class.new(nil)}.to raise_error("Name is required")
  end

  it 'is expected to have a :cash attribute with the value of 0 on initialize' do
    expect(subject.cash).to eq 0
  end

  it 'is expected to have :account attribute' do
    expect(subject.account).to be nil
  end
  
  describe 'can create an account' do

    before {subject.create_account}
    
    it "of Account class" do
      expect(subject.account.owner).to be_an_instance_of Person
    end

    it 'with himself as an owner' do
      expect(subject.account.owner).to be subject
    end
  end

  describe 'can manage funds if an account has been created' do

    let(:atm) {Atm.new}
    before{subject.create_account}

    it 'can deposit funds' do 
      expect(subject.deposit(100)).to be_truthy
    end
  end

  describe "can't manage funds if no account has been created" do

    it 'can\'t deposit funds' do
      expect {subject.deposit(100)}.to raise_error(RuntimeError, 'No account present')
    end
  end
end
