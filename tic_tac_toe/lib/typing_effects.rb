require 'colorize'
module TypingEffects

  def self.standard_typing(string)
    
    string.each_char do |char|
      print char    
      sleep(rand(0.04..0.07))
    end
  end

  def self.slow_steady_typing(string)

    string.each_char do |char|
      print char
      sleep(0.3)
    end
  end

  def self.very_slow_typing(string)

    string.each_char do |char|
      print char
      sleep(0.5)
    end
  end

  def self.yellow_typing(string)

    string.each_char do |char|
      print char.yellow
      sleep(rand(0.01..0.03))
    end
  end

  def self.evil_typing(string)

    string.each_char do |char|
      print char.red
      sleep(0.2)
    end
  end

  def self.red_typing(string)

    string.each_char do |char|
      print char.red
      sleep(rand(0.04..0.07))
    end
  end

  def self.narrator2_typing(string)

    string.each_char do |char|
    print char.blue
    sleep(0.03)
    end
  end
end