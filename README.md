# Atm_Challenge_2021

**The Code**

An ATM project that allows a user to:

⚪ Create an account.
⚪ Check their balance.
⚪ Deposit funds into the account.
⚪ Withdraw funds from the account.

**Dependencies**

**Ruby** ( Ruby 3.3.7 (2025-01-15 revision be31f993d7) [x64-mingw-ucrt])

**RSpec**

**Setup**

Run the code on your program by:

**Clone my repository using the web URL:**

https://github.com/FahadBinQaiser/atm_challenge_2021.git

cd atm_challenge_2021

After cloning, run **bundle install** in your terminal and then run **rspec**

**Instructions:**

Open the terminal and type the command irb

**Load the required files:**

require './lib/person'
require './lib/account' (If this returns false, use load instead)
require './lib/atm'

**Create a new person:**
person = Person.new(name: "Pookiemon")

**Create an account for the person:**
person.create_account

**Create an ATM instance first**
atm = Atm.new

**Set pin_code value to a variable**
pin_code = person.account.pin_code

**Give cash to the person**
person.cash= 100

**Then deposit money to account**
person.deposit(100)

#### To check cash, type person.cash or for the full details type person.account

**Withdraw funds:**

person.withdraw(amount:50, atm: atm, pin:pin_code)

**Check balance:**
Check balance with **person.account.balance** or **person.account** to see both the cash and account money

person.account.balance
person.account

**License**

This project is licensed under the MIT License. See the LICENSE file for more details.
