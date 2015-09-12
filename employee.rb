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
    @reviews
    @reviews[-1].split
    if input.scan(/Zeke/)#rules here to check if negative
      @performance = false
    elsif input.scan(/Xavier/)#rules here to check if positive
      @performance = true
    else
      puts "Sorry - this review cannot determine the employee's performance."
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

  # def auto_set_performance(input)
  #   self.reviews(input)
  #   @reviews[-1].split
  #     if input.scan(/positive/)#rules here to check if negative
  #       @performance = false
  #     elsif input.scan(/asset/)#rules here to check if positive
  #       @performance = true
  #     else
  #       puts "Sorry - this review cannot determine the employee's performance."
  #     end
  # end

  def give_raise(amount)
    @salary = @salary + amount
  end

end
