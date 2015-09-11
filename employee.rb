class Employee

  attr_reader :name, :email, :phone, :salary, :reviews, :performance

  def initialize(name, email = "", phone = "", salary = 0)
    @name = name
    @email = email
    @phone = phone
    @salary = salary
    @reviews = []
    @performance = false
  end

  def reviews(item)
    @reviews << item
    @reviews
  end

  def performing_well
    @performance = true
  end

  def performing_poorly
    @performance = false
  end  

end
