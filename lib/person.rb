require_relative 'account'

class Person
  attr_reader :name, :cash, :account
  def initialize(name, cash = 0)
    raise "Name is required" if name.nil?
    
    @name = name
    @cash = cash
    @account = nil
  end

    def create_account
      @account = Account.new(owner: self, balance: 0) 
    end
    def deposit(amount)
      raise "No account present" if @account.nil?
    
      @account.balance += amount
      true
    end
    
end
