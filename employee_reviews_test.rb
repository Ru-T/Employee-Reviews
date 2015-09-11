require 'minitest/autorun'
require 'minitest/pride'

#Note: This line is going to fail first.
require './employee_reviews.rb'

$mock_inputs = []
def get_user_input
  $mock_inputs.shift
end

class EmployeeReviewTest < Minitest::Test

  def test_employee_class_exists
    assert Employee
  end

  def test_department_class_exists
    assert Department
  end

  def test_initialize_department
    assert Department.new("Law")
    assert_raises(ArgumentError) do
      Department.new
    end
    assert_raises(ArgumentError) do
      Department.new(1, 2, 3)
    end
  end

  def test_intialize_employee
    assert Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", 100000)
    assert_raises(ArgumentError) do
      Employee.new
    end
    assert_raises(ArgumentError) do
      Employee.new(1, 2, 3, 4, 5)
    end
  end

  def test_add_employee_to_department
    law = Department.new("Law", [])
    employee = Employee.new("Ilan", "ilan@gmail.com", "900-432-4320", 80000)
    assert law << employee
  end

  def test_get_employee_name
    assert_equal "Ruti", Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", 100000).name
  end

  def test_get_employee_salary
    assert_equal 100000, Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", 100000).salary
  end

  def test_get_department_name
    assert_equal "Law", Department.new("Law").name
  end

  def test_get_total_salary_department
    law = Department.new("Law")
    employee = Employee.new("Ilan", "ilan@gmail.com", "900-432-4320", 80000)
    law << employee
    employee2 = Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", 100000)
    law << employee2
    assert_equal 180000, law.total_employee_salary
  end

  def test_add_review_to_employee
    employee = Employee.new("Ruti")
    review = "This employee is truly awesome!"
    assert_equal ["This employee is truly awesome!"], employee.reviews(review)
  end

end


# assert_equal "rwajnberg@gmail.com", Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", "$100,000").email
# assert_equal "908-432-4320", Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", "$100,000").phone
