class Transaction
  def initialize(day, amount, type)
    @day = day
    @amount = amount
    @type = type
  end

  def to_s
    "DAY: #{@day} | AMOUNT: #{@amount} | TYPE: #{@type}"
  end
end