class Department

attr_reader :name, :employees

  def initialize(name, employees = [])
    @name = name
    @employees = employees
  end

  def <<(item)
    @employees << item
  end

  def total_employee_salary
    @employees.reduce(0){|sum, employee| sum + employee.salary}
  end

  def department_raise(amount)
    @employees.each do |employee|
      if employee.performance == true
        employee.give_raise(amount/@employees.length)
      end
    end
  end

end
