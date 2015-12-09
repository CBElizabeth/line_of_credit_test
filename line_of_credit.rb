class LineOfCredit
  attr_reader :credit_limit, :apr, :balance, :accrued_interest, :transactions

  def initialize(credit_limit, apr)
    @credit_limit = credit_limit
    @apr = apr
    @balance = 0
    @accrued_interest = 0
    @day_of_last_event = 0
    @transactions = Array.new
  end

  def draw(amount, day)
    calculate_accrued_interest(day)
    if @balance + amount <= @credit_limit
      @balance += amount
      @transactions.push(Transaction.new(day, amount, "draw"))
    else
      #reject transaction because it exceeds credit limit
      @transactions.push(Transaction.new(day, amount, "rejected draw"))
    end
    @day_of_last_event = day
  end

  def pay(amount, day)
    calculate_accrued_interest(day)
    @balance -= amount
    @transactions.push(Transaction.new(day, amount, "payment"))
    @day_of_last_event = day
  end

  def show_transactions
    puts @transactions
  end

  def display_account
    puts "Balance: #{@balance.round(2)}"
    puts "APR: #{@apr}"
    puts "Credit Limit: #{@credit_limit}"
    puts "Accrued Interest: #{@accrued_interest.round(2)}"
  end

  def apply_monthly_interest(day)
    calculate_accrued_interest(day)
    @balance += @accrued_interest
    @transactions.push(Transaction.new(day, @accrued_interest, "interest charge"))
    @accrued_interest = 0
  end

  def calculate_accrued_interest(day)
    @accrued_interest = @accrued_interest + @balance * @apr / 365 * (day - @day_of_last_event)
  end
end