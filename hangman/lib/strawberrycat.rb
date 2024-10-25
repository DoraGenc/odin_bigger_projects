class StrawberryCat

  attr_reader :mood

  def initialize
    @mood = 0
  end

  def change_mood(value)

    @mood += value

    if @mood > 3 
      @mood = 3
    elsif @mood < -3
      @mood = -3
    end
  end
end