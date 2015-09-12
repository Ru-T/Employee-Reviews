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

  # def department_raise(amount)
  #   @employees.each do |employee|
  #     if employee.performance == true
  #       employee.give_raise(amount/@employees.length)
  #     end
  #   end
  # end

    def department_raise(amount)
      chosen_employees = []
      @employees.each do |employee|
        if employee.performance == true
          chosen_employees << employee
        end
      end
      @employees.each do |employee|
        if employee.performance == true
          employee.give_raise(amount/chosen_employees.length)
        end
      end
    end

    def department_raise_block(amount)
      chosen_employees = []
      @employees.each do |employee|
        if yield(employee)
          chosen_employees << employee
        end
      end
      @employees.each do |employee|
        if yield(employee)
          employee.give_raise(amount/chosen_employees.length)
        end
      end
    end


  #
  #
  # def department_raise_block(amount)
  #   @employees.select do |employee|
  #     if yield(employee)
  #       employee.give_raise(amount/@employees.length)
  #     end
  #   end
  # end




end
