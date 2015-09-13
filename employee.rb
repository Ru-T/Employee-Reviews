require 'byebug'

class Employee

  attr_reader :name, :email, :phone, :salary, :reviews, :performance

  def initialize(name, email = "", phone = "", salary = 0)
    @name = name
    @email = email
    @phone = phone
    @salary = salary
    @reviews = []
    @performance = "Performance is not yet set."
  end

  def reviews(input)
    @reviews << input
    counter = 0
    positive = []
    positive_words = ["asset", "pleasure", "happy", "perfect", "devoted",]
    positive_words.each do |word|
      positive = @reviews[-1].scan(/\b#{word}\b/i)
      counter += positive.length
    end
    negative = []
    negative_words = ["improvement", "difficult", "confusion", "interrupt"]
    negative_words.each do |word|
      negative = @reviews[-1].scan(/\b#{word}\b/i)
      counter -= negative.length
    end
    negative_prefixes = []
    neg_prefixes = ["dis", "anti", "non"]
    neg_prefixes.each do |prefix|
      negative_prefixes = @reviews[-1].scan(/#{prefix}\w+/i) #why isn't ^ working here??
      puts negative_prefixes
      counter -= negative_prefixes.length
    end
    puts counter
    if counter >= 1
       @performance = true
    elsif counter <= 0
       @performance = false
    else puts "Sorry - this review cannot determine the employee's performance."
    end
  end

  def set_performance(input)
    if input == "Good"
      @performance = true
    elsif input == "Bad"
      @performance = false
    else
      puts "This is not a valid way to set performance."
    end
  end

  def give_raise(amount)
    @salary = @salary + amount
  end

end
