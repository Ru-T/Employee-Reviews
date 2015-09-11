class Department

attr_reader :name, :employees

  def initialize(name, employees = [])
    @name = name
    @employees = employees
  end

  def <<(item)
    @employees << item
  end

end
