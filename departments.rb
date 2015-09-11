class Department

attr_reader :name

  def initialize(name, employees = [])
    @name = name
    @employees = employees
  end

end
