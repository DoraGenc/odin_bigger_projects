require 'colorize'

def pause(time = 0.3)
  sleep(time)
end

def print_names(player)
  if player.is_a?(Guesser)
    print 'You: '.bold.green

  else
    print 'Computer: '.bold.red
  end
end

module TypingEffects
  def self.standard_typing(string)
    string.each_char do |char|
      print char
      sleep(rand(0.03..0.05))
    end
  end

  def self.computer_typing(string)
    string.each_char do |char|
      print char.red
      sleep(rand(0.03..0.05))
    end
  end

  def self.very_slow_typing(string)
    string.each_char do |char|
      print char
      sleep(0.5)
    end
  end
end

module Colors
  COLORS =['black', 'red', 'green', 'yellow', 'blue', 'magenta']

  def print_colors
    COLORS.each_with_index do |color, index|
      puts 'Color: ' + "#{color}".colorize(color.to_sym) + ', Index:' + "#{index}".colorize(color.to_sym)
    end
  end
end

module SecretCode
  def generate_secret_code
    secret_code = Array.new(4) { (0..7).to_a.sample } # 0-7 repräsentiert die Index-Zahlen von COLORS
    puts "SECRET CODE IS: #{secret_code}"
    secret_code
  end
end

module GiveFeedback
  def feedback
    matching_colors = 0
    matching_index = 0

    guessed_code.each do |guess|
      matching_colors += 1 if secret_code.include?(guess)
    end

    guessed_code.each_with_index do |guess, index|
      matching_index += 1 if secret_code[index] == guess
    end

    print_names(computer)
    TypingEffects.standard_typing(" You guessed #{matching_colors}/4 correctly. #{matching_index}/4 are in the right position...\n")
    sleep(2)

    return unless matching_colors == 4 && matching_index == 4

    @win = true
  end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Guesser < Player
  attr_accessor :guess

  def initialize(name)
    super(name) # Ruft den Initialisierer der Superklasse (Player) auf, weil sonst ja kein Name erstellt werden könnte
    @guess = []
  end
end

class Game
  include SecretCode
  include GiveFeedback
  include Colors

  attr_accessor :guesser, :computer, :secret_code, :guess_counter, :guessed_code, :win

  def initialize(guesser, computer)
    @guess_counter = 0
    @guesser = guesser
    @computer = computer
    @guessed_code = []

    @secret_code = generate_secret_code
  end

  def opening_dialogue
    TypingEffects.standard_typing('The '.yellow + 'Computer'.bold.red + ' generated a '.yellow + "Secret Code!\n".bold.yellow)
    TypingEffects.standard_typing('The ' + 'Secret Code '.bold + "consists of 4 random colors in random positions.\n")
    TypingEffects.standard_typing('You can guess twelve times. Every time, the ' + 'Computer '.bold.red + "must give you feedback about how good your guess was.\n")
    TypingEffects.standard_typing('If you can guess the ' + 'Secret Code '.bold + 'in a maximum of 12 guesses, you ' + "win!\n".bold.blue)

    print_names(@computer)
    TypingEffects.computer_typing("Pah! Or else, you loose!\n")
    pause
    print_names(@computer)
    TypingEffects.computer_typing("Blehh!! :P\n")
    pause
  end

  def play_game
    first_dialogue
    opening_dialogue

    win

    until @guess_counter >= 12 || win

      @guess_counter = + 1
      @guessed_code = guess_combination
      feedback
    end
    announce_result
  end

  def guess_combination
    guessed_code = []

    puts "\nHuman".bold.green + ', please guess a combination of colors.'
    puts "In the following, please enter the Index of the color you want to choose.\n"
    puts "\nThose are all possible colors:\n "

    while guessed_code.length < 4
      valid_input = false

      until valid_input # Die Schleife fragt so lange den gleichen Tag ab, bis die Eingabe valid ist

        print_colors
        puts("\nPlease choose your guess by entering the corresponding index number: ")
        single_guess = gets.chomp

        if single_guess.match?(/\A[0-7]\z/)
          guessed_code << single_guess.to_i
          valid_input = true
        else
          puts 'Invalid input. Please enter an index number between 0 and 7. Do not type in letters or other characters.'
        end
      end
    end

    guessed_colors = guessed_code.map { |index| COLORS[index] }

    formatted_colors = guessed_colors.map { |color| color.colorize(color.to_sym) }.join(', ')

    TypingEffects.standard_typing("You guessed: #{formatted_colors}\n")
    guessed_code
  end

  def announce_result
    TypingEffects.standard_typing('Congratulations! ' + 'The winner is: ' + "#{guesser.name}\n".bold.blue)
    pause

    print_names(@computer)
    TypingEffects.computer_typing('You CHEATER!!!!! :((')
  end
end

# Mastermind spielen, Dialog & Spielername

guesser = Guesser.new('Human')
computer = Player.new('Computer')

def first_dialogue
  TypingEffects.standard_typing("Hello, Players!\nAnd Welcome to " + 'Mastermind'.bold + "!\n")
  TypingEffects.standard_typing('How are you today?')
  pause
  puts
  TypingEffects.standard_typing('Well, ' + 'Human'.bold.green)
  pause
  # print human_name
  print ','
  pause
  TypingEffects.standard_typing(" I hope you're in top form today ")
  pause(0.3)
  TypingEffects.standard_typing('because you’ll be facing off in Mastermind against your opponent, a')
  TypingEffects.very_slow_typing('...')
  TypingEffects.computer_typing("Computer.\n")
  pause

  print_names(computer)
  TypingEffects.computer_typing('HAHAHA! ')
  pause
  TypingEffects.computer_typing('Little ')
  TypingEffects.standard_typing('Human'.bold.green)
  TypingEffects.computer_typing(", you don't stand a chance against ")
  TypingEffects.standard_typing('ME'.red.bold)
  TypingEffects.computer_typing(', a superior ')
  TypingEffects.standard_typing('CREATURE'.bold.red + "!\n".red)
  pause
  print_names(computer)
  TypingEffects.computer_typing('You may try your best, but ')
  TypingEffects.standard_typing('victory'.bold.blue)
  TypingEffects.computer_typing(" is not within your grasp.\n")
  pause

  print_names(computer)
  TypingEffects.computer_typing('Prepare yourself for ')
  TypingEffects.standard_typing("the ultimate challenge!\n".bold.red)
  pause

  print_names(computer)
  TypingEffects.computer_typing('I will show no mercy. Get ready for ')
  TypingEffects.standard_typing("the battle of wits.\n".bold.red)
  pause

  TypingEffects.standard_typing('Are you ready? The game')
  TypingEffects.very_slow_typing('...')
  pause
  TypingEffects.standard_typing("begins now!\n".bold.yellow)
  pause
end

game = Game.new(guesser, computer)
game.play_game
