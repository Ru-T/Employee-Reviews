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

  def reviews(input)
    @reviews << input
    if @reviews[-1].scan(/Wanda/) != []#rules here to check if positive
      @performance = true
    elsif @reviews[-1].scan(/Zeke/) != []#rules here to check if negative
      @performance = false
    else
      puts "Sorry - this review cannot determine the employee's performance."
    end
  end

  #array.select {|n| n.match(/\b#{name}\b/i)}

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
