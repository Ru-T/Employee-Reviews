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

  def reviews(item)
    @reviews << item
    @reviews
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

  def give_raise(percent)
    @salary + @salary * percent
  end

end
