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
    assert_equal "Law", Department.new("Law").name
  end

  def test_intialize_employee
    assert_equal "Ruti", Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", "$100,000").name
    assert_equal "rwajnberg@gmail.com", Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", "$100,000").email
    assert_equal "908-432-4320", Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", "$100,000").phone
    assert_equal "$100,000", Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", "$100,000").salary
  end

end

  #
  #   def test_initialize_employee
  #     assert OddArray.new([1, 2, 3])
  #     assert_raises(ArgumentError) do
  #       OddArray.new
  #     end
  #     assert_raises(ArgumentError) do
  #       OddArray.new(1, 2, 3)
  #     end
  #   end
  # # def self.test_order
  # #   :alpha
  # # end
  #
  #
  #
  # #placeholder for Test 2 depending on logic between Module of Departments and Employees
