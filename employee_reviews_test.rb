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
    assert Employee.new(name: "Ruti", email: "rwajnberg@gmail.com", phone: "908-432-4320", salary: 100000)
    assert_raises(ArgumentError) do
      Employee.new
    end
    assert_raises(ArgumentError) do
      Employee.new(1, 2, 3, 4, 5)
    end
  end

  def test_add_employee_to_department
    law = Department.new("Law")
    employee = Employee.new(name: "Ilan", email: "ilan@gmail.com", phone: "900-432-4320", salary: 80000)
    assert law << employee
  end

  def test_get_employee_info
    ruti = Employee.new(name: "Ruti", salary: 100000)
    assert_equal "Ruti", ruti.name
    assert_equal 100000, ruti.salary
  end

  def test_get_department_name
    assert_equal "Law", Department.new("Law").name
  end

  def test_get_total_salary_department
    law = Department.new("Law")
    employee = Employee.new(name: "Ilan", email: "ilan@gmail.com", salary: 80000)
    law << employee
    employee2 = Employee.new(name: "Ruti", salary: 100000)
    law << employee2
    assert_equal 180000, law.total_employee_salary
  end

  def test_add_review_to_employee_and_auto_set_performance
    employee1 = Employee.new(name: "Yvonne")
    review1 = "Thus far, there have been two concerns over Yvonne's performance, and both have been discussed with her in internal meetings.  First, in some cases, Yvonne takes longer to complete tasks than would normally be expected.  This most commonly manifests during development on existing applications, but can sometimes occur during development on new projects, often during tasks shared with Andrew.  In order to accommodate for these preferences, Yvonne has been putting more time into fewer projects, which has gone well.
    Second, while in conversation, Yvonne has a tendency to interrupt, talk over others, and increase her volume when in disagreement.  In client meetings, she also can dwell on potential issues even if the client or other attendees have clearly ruled the issue out, and can sometimes get off topic."
    employee1.reviews(review1)
    assert_equal false, employee1.performance

    employee2 = Employee.new(name: "Zeke")
    review2 = "Zeke is a very positive person and encourages those around him, but he has not done well technically this year.  There are two areas in which Zeke has room for improvement.  First, when communicating verbally (and sometimes in writing), he has a tendency to use more words than are required.  This conversational style does put people at ease, which is valuable, but it often makes the meaning difficult to isolate, and can cause confusion.
    Second, when discussing new requirements with project managers, less of the information is retained by Zeke long-term than is expected.  This has a few negative consequences: 1) time is spent developing features that are not useful and need to be re-run, 2) bugs are introduced in the code and not caught because the tests lack the same information, and 3) clients are told that certain features are complete when they are inadequate.  This communication limitation could be the fault of project management, but given that other developers appear to retain more information, this is worth discussing further."
    employee2.reviews(review2)
    assert_equal false, employee2.performance

    employee3 = Employee.new(name: "Wanda")
    review3 = "Wanda has been an incredibly consistent and effective developer.  Clients are always satisfied with her work, developers are impressed with her productivity, and she's more than willing to help others even when she has a substantial workload of her own.  She is a great asset to Awesome Company, and everyone enjoys working with her.  During the past year, she has largely been devoted to work with the Cement Company, and she is the perfect woman for the job.  We know that work on a single project can become monotonous, however, so over the next few months, we hope to spread some of the Cement Company work to others.  This will also allow Wanda to pair more with others and spread her effectiveness to other projects."
    employee3.reviews(review3)
    assert_equal true, employee3.performance

    employee4 = Employee.new(name: "Xavier")
    review4 = "Xavier is a huge asset to SciMed and is a pleasure to work with.  He quickly knocks out tasks assigned to him, implements code that rarely needs to be revisited, and is always willing to help others despite his heavy workload.  When Xavier leaves on vacation, everyone wishes he didn't have to go
    Last year, the only concerns with Xavier performance were around ownership.  In the past twelve months, he has successfully taken full ownership of both Acme and Bricks, Inc.  Aside from some false starts with estimates on Acme, clients are happy with his work and responsiveness, which is everything that his managers could ask for."
    employee4.reviews(review4)
    assert_equal true, employee4.performance
  end

  def test_employee_performance #Mark whether an employee is performing satisfactorily or not satisfactorily.
    employee = Employee.new(name: "Ruti")
    employee.set_performance("Good")
    assert employee.performance
    employee.set_performance("Bad")
    refute employee.performance
  end

  def test_individual_raise
    employee = Employee.new(name: "Ruti", salary: 100000)
    assert_equal 120000, employee.give_raise(20000)
  end

  def test_department_raise #modify this test to include the performance logic
    law = Department.new("Law")
    employee = Employee.new(name: "Ruti", salary: 100000)
    law << employee
    employee2 = Employee.new(name: "Ilan", salary: 80000)
    employee2.set_performance("Good")
    law << employee2
    employee3 = Employee.new(name: "Joelle", salary: 120000)
    employee3.set_performance("Bad")
    law << employee3
    law.department_raise(9000)
    assert_equal 100000, employee.salary
    assert_equal 89000, employee2.salary
    assert_equal 120000, employee3.salary
  end

  def test_department_raise_block
    law = Department.new("Law")
    employee = Employee.new(name: "Ruti", salary: 100000)
    law << employee
    employee2 = Employee.new(name: "Ilan", salary: 80000)
    employee2.set_performance("Good")
    law << employee2
    employee3 = Employee.new(name: "Joelle", salary: 120000)
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

end
