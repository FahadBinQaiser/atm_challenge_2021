# frozen_string_literal: true

require 'date'
# An ATM that handles withdrawals and deposits.
class Atm
  attr_accessor :funds

  def initialize
    @funds = 1000
  end

  def withdraw(amount, pin_code, account, account_status)
    return error_response('account disabled') if account_status?(account_status)
    return error_response('insufficient funds') if insufficient_funds_in_account?(amount, account)
    return error_response('insufficient funds in ATM') if insufficient_funds_in_atm?(amount)
    return error_response('wrong pin') if incorrect_pin?(pin_code, account.pin_code)
    return error_response('card expired') if card_expired?(account.exp_date)

    perform_transaction(amount, account)
  end

  def error_response(message)
    { status: false, message: message, date: Date.today }
  end


  private

  def insufficient_funds_in_account?(amount, account)
    amount > account.balance
  end

  def incorrect_pin?(pin_code, actual_pin)
    pin_code != actual_pin
  end

  def insufficient_funds_in_atm?(amount)
    @funds < amount
  end

  def account_status?(account_status)
    account_status == :active
  end

  def card_expired?(exp_date)
    Date.strptime(exp_date, '%m/%y') < Date.today
  end

  def perform_transaction(amount, account)
    @funds -= amount
    account.balance = account.balance - amount
    { status: true, message: 'success', date: Date.today, amount: amount, bills: add_bills(amount) }
  end

  def add_bills(amount)
    denominations = [20, 10, 5]
    bills = []
    denominations.each do |bill|
      while amount - bill >= 0
        amount -= bill
        bills << bill
      end
    end
    bills
  end
end
