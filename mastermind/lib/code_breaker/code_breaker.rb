

class CodeBreaker

  def initialize

    @S = (0..5).to_a.repeated_permutation(4).to_a

    @possible_codes = @S.dup
    @feedback = nil

    @is_first_guess = true
    @first_guess = [0, 0, 1, 1]

    @last_guess = nil
    @winning_code = nil
  end 


  # guess entscheidet zuerst, wie vorgegangen wird

  def guess(counted_blows_and_hits)

    unless is_first_guess
      puts "\nfeedback before: #{@feedback.inspect}"
      get_feedback(counted_blows_and_hits)
      puts "feedback after: #{@feedback.inspect}"
    end 

    @last_guess = create_guess
    puts "possible codes length = #{possible_codes.length}"

    return @last_guess
  end 

  def create_guess

    if is_first_guess

      puts "it's the first guess!"

      @is_first_guess = false #hier ist @ nötig,
      guess = first_guess #aber hier nicht?!

    else 
      mimic

      unless winning_code == nil
        guess = winning_code
      else 
        guess = possible_codes.sample
     end

    end 
    return guess
  end 


  # mimic 

  def mimic

    possible_codes.each do |possible_code|

      mimicked_feedback = mimic_feedback(possible_code)
    end
  end


  def mimic_feedback(code)

    blows = 0
    hits = 0 

    color_count = Hash.new(0)
    last_guess.each { |color| color_count[color] += 1 }


    code.each_with_index do |number, index|
  
      if last_guess[index] == number
        hits += 1
        color_count[number] -= 1
      end 
    end 

    code.each_with_index do |number, index|

      if last_guess.include?(number) && color_count[number] > 0
        blows += 1
        color_count[number] -= 1
      end
    end 

    mimicked_feedback = [blows, hits]

    if mimicked_feedback != @feedback
      laser_beam(code)

    elsif mimicked_feedback == [4, 0]
      @winning_code = code
    end

    mimicked_feedback
  end

  def laser_beam(impossible_code)
    possible_codes.delete(impossible_code)
  end
  
  def get_feedback(blows_and_hits)
    @feedback = blows_and_hits #geht nicht mit nur "feedback"????
  end


  private

  attr_accessor :feedback, :possible_codes, :is_first_guess, :last_guess, :winning_code
  attr_reader :first_guess
end 