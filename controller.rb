class LOCController
  def run
    @day = 0
    @line_of_credit = LineOfCredit.new(1000, 0.35)
    display_main_menu
  end

  def display_main_menu
    valid_selections = ["1", "2", "3", "4", "5", "6"]
    selection = false
    until selection
      puts
      puts "Welcome to Real Actual Bank"
      puts "Current Day is: #{@day}"
      puts "  Please select an option: "
      puts "    1. View Account Information"
      puts "    2. Make Withdrawal"
      puts "    3. Make Payment"
      puts "    4. Show Transactions"
      puts "    5. Progress Days"
      puts "    6. Exit"
      selection = gets.chomp
      unless valid_selections.include?(selection)
        selection = false
      end
    end

    case selection
    when "1"
      do_view_account_information
    when "2"
      do_make_withdrawal
    when "3"
      do_make_payment
    when "4"
      do_show_transactions
    when "5"
      do_progress_days
    when "6"
      do_exit
    else
      display_main_menu
    end
  end

  def do_view_account_information
    puts "-------------------------"
    @line_of_credit.display_account
    wait
  end

  def do_make_withdrawal
    puts "-------------------------"
    puts "Available Credit: #{@line_of_credit.credit_limit - @line_of_credit.balance}"
    puts "How much would you like to draw?"
    withdrawal = gets.chomp.to_i
    @line_of_credit.draw(withdrawal, @day)
    wait
  end

  def do_make_payment
    puts "-------------------------"
    puts "Current Balance: #{@line_of_credit.balance}"
    puts "How much would you like to pay?"
    payment = gets.chomp.to_i
    @line_of_credit.pay(payment, @day)
    wait
  end

  def do_show_transactions
    puts "-------------------------"
    puts "Previous Transactions:"
    @line_of_credit.show_transactions
    wait
  end

  def do_progress_days
    puts "-------------------------"
    puts "Enter the number of days to add..."
    @day += gets.chomp.to_i
    if @day == 30
      @line_of_credit.apply_monthly_interest(@day)
    end
    wait
  end

  def do_exit
    exit
  end

  def wait
    puts "-------------------------"
    puts "Press any key to return to main menu..."
    gets
    display_main_menu
  end
end