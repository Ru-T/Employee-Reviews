require 'minitest/autorun'
require 'minitest/pride'
require 'byebug'

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

  def test_get_employee_info
    ruti = Employee.new("Ruti", "rwajnberg@gmail.com", "908-432-4320", 100000)
    assert_equal "Ruti", ruti.name
    assert_equal 100000, ruti.salary
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

  def test_add_review_to_employee_and_auto_set_performance
    # employee = Employee.new("Ruti")
    # review = "This employee is truly awesome!"
    # assert_equal ["This employee is truly awesome!"], employee.reviews(review)
    employee1 = Employee.new("Zeke")
    review1 = "Zeke is a very positive person and encourages those around him, but he has not done well technically this year.  There are two areas in which Zeke has room for improvement.  First, when communicating verbally (and sometimes in writing), he has a tendency to use more words than are required.  This conversational style does put people at ease, which is valuable, but it often makes the meaning difficult to isolate, and can cause confusion.
    Second, when discussing new requirements with project managers, less of the information is retained by Zeke long-term than is expected.  This has a few negative consequences: 1) time is spent developing features that are not useful and need to be re-run, 2) bugs are introduced in the code and not caught because the tests lack the same information, and 3) clients are told that certain features are complete when they are inadequate.  This communication limitation could be the fault of project management, but given that other developers appear to retain more information, this is worth discussing further."
    employee1.reviews(review1)
    assert_equal false, employee1.performance

    employee2 = Employee.new("Xavier")
    review2 = "Xavier is a huge asset to SciMed and is a pleasure to work with.  He quickly knocks out tasks assigned to him, implements code that rarely needs to be revisited, and is always willing to help others despite his heavy workload.  When Xavier leaves on vacation, everyone wishes he didn't have to go
    Last year, the only concerns with Xavier performance were around ownership.  In the past twelve months, he has successfully taken full ownership of both Acme and Bricks, Inc.  Aside from some false starts with estimates on Acme, clients are happy with his work and responsiveness, which is everything that his managers could ask for."
    employee2.reviews(review2)
    puts employee2.performance
    assert_equal true, employee2.performance
  end

  def test_employee_performance #Mark whether an employee is performing satisfactorily or not satisfactorily.
    employee = Employee.new("Ruti")
    employee.set_performance("Good")
    assert employee.performance
    employee.set_performance("Bad")
    refute employee.performance
  end

  def test_individual_raise
    employee = Employee.new("Ruti", "", "", 100000)
    assert_equal 120000, employee.give_raise(20000)
  end

  def test_department_raise #modify this test to include the performance logic
    law = Department.new("Law")
    employee = Employee.new("Ruti", "", "", 100000)
    law << employee
    employee2 = Employee.new("Ilan", "", "", 80000)
    employee2.set_performance("Good")
    law << employee2
    employee3 = Employee.new("Joelle", "", "", 120000)
    employee3.set_performance("Bad")
    law << employee3
    law.department_raise(9000)
    assert_equal 100000, employee.salary
    assert_equal 89000, employee2.salary
    assert_equal 120000, employee3.salary
  end

  def test_department_raise_block
    law = Department.new("Law")
    employee = Employee.new("Ruti", "", "", 100000)
    law << employee
    employee2 = Employee.new("Ilan", "", "", 80000)
    employee2.set_performance("Good")
    law << employee2
    employee3 = Employee.new("Joelle", "", "", 120000)
    employee3.set_performance("Bad")
    law << employee3
    law.department_raise_block(9000){|employee| employee.performance == true}
    assert_equal 100000, employee.salary
    assert_equal 89000, employee2.salary
    assert_equal 120000, employee3.salary

    law.department_raise_block(9000){|employee| employee.salary > 90000}
    assert_equal 104500, employee.salary
    assert_equal 89000, employee2.salary
    assert_equal 124500, employee3.salary

    law.department_raise_block(9000){|employee| employee.salary < 100000}
    assert_equal 104500, employee.salary
    assert_equal 98000, employee2.salary
    assert_equal 124500, employee3.salary
  end

  # def test_set_performance_by_scanning_reviews
  #   employee = Employee.new("Zeke")
  #   review = "Zeke is a very positive person and encourages those around him, but he has not done well technically this year.  There are two areas in which Zeke has room for improvement.  First, when communicating verbally (and sometimes in writing), he has a tendency to use more words than are required.  This conversational style does put people at ease, which is valuable, but it often makes the meaning difficult to isolate, and can cause confusion.
  #   Second, when discussing new requirements with project managers, less of the information is retained by Zeke long-term than is expected.  This has a few negative consequences: 1) time is spent developing features that are not useful and need to be re-run, 2) bugs are introduced in the code and not caught because the tests lack the same information, and 3) clients are told that certain features are complete when they are inadequate.  This communication limitation could be the fault of project management, but given that other developers appear to retain more information, this is worth discussing further."
  #   employee.reviews(review)
  #   employee.auto_set_performance(review)
  #   assert_equal false, employee.performance
  #
  #   employee = Employee.new("Xavier")
  #   review = "Xavier is a huge asset to SciMed and is a pleasure to work with.  He quickly knocks out tasks assigned to him, implements code that rarely needs to be revisited, and is always willing to help others despite his heavy workload.  When Xavier leaves on vacation, everyone wishes he didn't have to go
  #   Last year, the only concerns with Xavier performance were around ownership.  In the past twelve months, he has successfully taken full ownership of both Acme and Bricks, Inc.  Aside from some false starts with estimates on Acme, clients are happy with his work and responsiveness, which is everything that his managers could ask for."
  #   employee.reviews(review)
  #   employee.auto_set_performance
  #   assert_equal true, employee.performance
  # end

end
