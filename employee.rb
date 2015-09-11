class Employee

  attr_reader :name, :email, :phone, :salary

  def initialize(name, email = "", phone = "", salary = 0)
    @name = name
    @email = email
    @phone = phone
    @salary = salary
    @reviews = []

  def reviews(item)
    @reviews << item
    @reviews
  end

  end

end
