# frozen_string_literal: true

require 'date'
# A bank account with balance and account details.
class Account
  STANDARD_VALIDITY_YRS = 5
  attr_reader :account_status, :owner, :pin_code, :withdraw, :exp_date
  attr_accessor :balance

  def initialize(attrs = {})
    @account_status = :active
    @balance = attrs[:balance] || 0
    @exp_date = set_expire_date
    @pin_code = rand(1000..9999)
    set_owner(attrs[:owner])
  end

  def set_expire_date
    Date.today.next_year(Account::STANDARD_VALIDITY_YRS).strftime('%m/%y')
  end

  def deactivate
    @account_status = :deactivated
  end

  private

  def set_owner=(obj)
    obj.nil? ? missing_owner : @owner = obj
  end

  def missing_owner
    raise 'An Account owner is required'
  end
end

# Instance method will shut down (deactivate) the single account

# but the class method will deactivate all accounts there .

# (Do you really need Account::STANDARD_VALIDITY_YRS? Perhaps STANDARD_VALIDITY_YRS in enough? Try it out...)

# We don't need to use Account::STANDARD_VALIDITY_YRS, we can use STANDARD_VALIDITY_YRS instead.
# because we are not calling it from another class. We can use it directly.
