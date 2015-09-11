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
  end

  def test_intialize_employee
    assert Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", "$100,000")
  end

  def test_add_employee_to_department
    law = Department.new("Law", ["Ruti Wajnberg"])
    assert law << "Ilan Man"
  end

end


# assert_equal "Ruti", Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", "$100,000").name
# assert_equal "rwajnberg@gmail.com", Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", "$100,000").email
# assert_equal "908-432-4320", Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", "$100,000").phone
# assert_equal "$100,000", Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", "$100,000").salary
