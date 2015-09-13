require 'byebug'

class Employee

  attr_reader :name, :email, :phone, :salary, :reviews, :performance

  def initialize(name, email = "", phone = "", salary = 0)
    @name = name
    @email = email
    @phone = phone
    @salary = salary
    @reviews = []
    @performance = "Performance is not yet set."
  end

# create one variable counter for pos and neg that starts at 0. increment for each condition in a weighted fashion.
  def reviews(input)
    @reviews << input
    counter = 0
    case
      when @reviews[-1].scan(/asset/) != []#rules here to check if positive
        counter += 1 * @reviews[-1].scan(/asset/).length
        puts counter
      when @reviews[-1].scan(/negative/) != []#rules here to check if negative
        counter -= 1 * @reviews[-1].scan(/negative/).length
        puts counter
    end
    if counter > 0
      @performance = true
    elsif counter <= 0
      @performance = false
    else puts "Sorry - this review cannot determine the employee's performance."
    end
  end

  def set_performance(input)
    if input == "Good"
      @performance = true
    elsif input == "Bad"
      @performance = false
    else
      puts "This is not a valid way to set performance."
    end
  end

  def give_raise(amount)
    @salary = @salary + amount
  end

end
