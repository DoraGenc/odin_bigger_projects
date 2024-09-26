class CodeBreaker
  def initialize
    @S = (0..5).to_a.repeated_permutation(4).to_a

    @possible_codes = @S.dup
    @feedback = nil

    @is_first_guess = true
    @first_guess = [0, 0, 1, 1]

    @last_guess = nil
  end

  # guess entscheidet zuerst, wie vorgegangen wird

  def guess(counted_blows_and_hits)
    get_feedback(counted_blows_and_hits) unless is_first_guess

    self.last_guess = create_guess
    puts possible_codes.inspect
    puts "possible codes length = #{possible_codes.length}"

    last_guess
  end

  def create_guess
    if is_first_guess

      puts "it's the first guess!"

      self.is_first_guess = false # hier ist @ nötig,
      guess = first_guess # aber hier nicht?!

    else
      mimic

      guess = if winning_code.nil?
                possible_codes.sample
              else
                winning_code
              end

    end
    guess
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

    code.each_with_index do |remaining_code, index|
      if last_guess[index] == remaining_code
        hits += 1
        color_count[remaining_code] -= 1
      end
    end

    code.each_with_index do |remaining_code, index|
      if last_guess[index] != remaining_code && color_count[remaining_code] > 0
        blows += 1
        color_count[remaining_code] -= 1
      end
    end

    mimicked_feedback = [blows, hits]

    return if mimicked_feedback == @feedback

    laser_beam(code)
  end

  def laser_beam(impossible_code)
    possible_codes.delete(impossible_code)
    print " #{impossible_code}"
  end

  def get_feedback(blows_and_hits)
    self.feedback = blows_and_hits # geht nicht mit nur "feedback"????
  end

  # def minimax

  # best_score = Float::INFINITY #spezielle Konstante

  # possible_codes.each do |possible_code|

  # end

  private

  attr_accessor :feedback, :possible_codes, :is_first_guess, :last_guess, :winning_code
  attr_reader :first_guess
end
