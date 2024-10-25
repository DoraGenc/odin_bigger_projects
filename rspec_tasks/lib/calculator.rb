
class Calculator

  def add(*number)
    number.reduce { |num1, num2| num1.to_f + num2}     
  end

  def multiply(*number)
    
    if number.size < 2
      return "Please type in more than one number."
    else
      number.reduce { |num1, num2| num1.to_f * num2}
    end 
  end

  def substract(*number)

    if number.size < 2
      return "Please type in more than one number."
    else
      number.reduce { |num1, num2| num1.to_f - num2}
    end
  end

  def divide(*number)

    if number.size < 2
      return "Please type in more than one number."
    else
      number.reduce { |num1, num2| num1.to_f / num2}
    end
  end
end