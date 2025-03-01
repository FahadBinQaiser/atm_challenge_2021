class Account
  STANDARD_VALIDITY_YRS = 5
  attr_reader :account_status, :owner 
  attr_accessor :balance
  def initialize(attrs = {})
  @account_status = :active
    set_owner(attrs[:owner]) 
    @balance = attrs[:balance]
  end

  def set_expire_date
  Date.today.next_year(Account::STANDARD_VALIDITY_YRS).strftime('%m/%y')
  end

  def deactivate
    @account_status = :deactivated
  end 
  private 
  def set_owner(obj)
    obj.nil? ? missing_owner : @owner = obj
  end
  def missing_owner
    raise 'An Account owner is required'
  end
end

# Instance method will shut down (deactivate) the single account but the class method will deactivate all accounts there .

# (Do you really need Account::STANDARD_VALIDITY_YRS? Perhaps STANDARD_VALIDITY_YRS in enough? Try it out...)

# We don't need to use Account::STANDARD_VALIDITY_YRS, we can use STANDARD_VALIDITY_YRS instead.
# because we are not calling it from another class. We can use it directly.