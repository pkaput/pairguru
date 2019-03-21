class TitleBracketsValidator < ActiveModel::Validator
  
  @@errors = {empty: "Brackets can't be empty", 
              not_closed: "Brackets not closed", 
              order: "Brackets wrong closing order"}

  def validate(validatable)
    brackets_check_empty validatable
    brackets_check_order validatable
  end

  def brackets_check_empty(validatable)
    unless (validatable.title.split & %w(() {} [])).empty?
      add_error(validatable, :empty)
    end
  end

  def brackets_check_order(validatable)
    stack = []
    brackets = { "{" => "}", "[" => "]", "(" => ")" }
    validatable.title.each_char do |c|
      stack << c if brackets.key?(c)
      if brackets.key(c) && brackets.key(c) != stack.pop
        add_error(validatable, :order)
      end
    end
    add_error(validatable, :not_closed) unless stack.empty?
  end

  def add_error(validatable, key)
    validatable.errors["brackets"] << @@errors[key]
  end
end
