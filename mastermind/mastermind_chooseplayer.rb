require 'colorize'

# CLASS Speech

def pause(time = 0.3)
  sleep(time)
end

# nichts
def print_names(player)
  
  if player.is_a?(Guesser)
    print "You: ".bold.green 
  
  else
    print "Computer: ".bold.red
  end
end

# CLASS Speech

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


# CLASS Colors

module Colors

  COLORS = ['black', 'red', 'green', 'yellow', 'blue', 'magenta']
  
  def print_colors
    COLORS.each_with_index do |color, index|
      puts "Color: " + "#{color}".colorize(color.to_sym) + ", Index:" + "#{index}".colorize(color.to_sym)
    end
  end

  def index_to_colors(index_array)

    colors_array = Array.new
  
    index_array.map do |index|
      color_name = COLORS[index]
      color_name = color_name.colorize(:color => color_name.to_sym)
      colors_array << color_name
    end 
    colors_array.join(', ') #Es lag an dem join!
  end 
end


module SecretCode

  # CLASS ComputerSetter
  def generate_secret_code
    @secret_code = Array.new(4) { (0..7).to_a.sample } # 0-7 repräsentiert die Index-Zahlen von COLORS
    puts "SECRET CODE IS: #{secret_code}"
  end 

  #CLASS HumanSetter
  def create_secret_code

    secret_code = Array.new
    TypingEffects.standard_typing("Hi " + "Human! ".bold.green + "Please create your Secret Code. You can type in 4 colors.\nThose are the colors you can choose from:\n\n"); pause
    print_colors
    pause(1)

    while secret_code.length < 4
      puts "\nPlease type in the index number: "
      single_secret_index = gets.chomp
  
      if single_secret_index.match?(/\A[0-7]\z/)
        secret_code << single_secret_index.to_i
      else
        puts "Invalid input. Please enter an index number between 0 and 7. Do not type in letters or other characters.".red
      end
    end

    TypingEffects.standard_typing("You created the code: ")
    print index_to_colors(secret_code)
    pause(1)

    @secret_code = secret_code
  end
end

# CLASS Feedback

module GiveFeedback

  def feedback
    blows = 0
    hits = 0
    
    guessed_code.each do |guess|
      if secret_code.include?(guess) # secret_code ist nil

        blows +=1
      end
    end 
    
    guessed_code.each_with_index do |guess, index|
      if secret_code[index] == guess

        hits += 1
      end
    end
    
    TypingEffects.standard_typing( "Blows: ".yellow + "#{blows}/4. " + "Hits: ".yellow + "#{hits}/4.\n")
    sleep(1)

    if blows == 4 && hits == 4
      @win = true
    else
      random_voiceline
    end
  end 
end 


# CLASS HumanGuesser

module GuessCombination

  def human_guess_combination

    guessed_code = Array.new

    puts "\nHuman".bold.green + ", please guess a combination of colors."
    puts "In the following, please enter the Index of the color you want to choose.\n"
    puts "\nThose are all possible colors:\n "
  
    while guessed_code.length < 4
      valid_input = false

      until valid_input # Die Schleife fragt so lange den gleichen Tag ab, bis die Eingabe valid ist

        print_colors
        puts ("\nPlease choose your guess by entering the corresponding index number: ")
        single_guess = gets.chomp
            
        if single_guess.match?(/\A[0-7]\z/)
          guessed_code << single_guess.to_i
          valid_input = true
        else
          puts 'Invalid input. Please enter an index number between 0 and 7. Do not type in letters or other characters.'
        end
      end
    end 

    # geratene Index-Zahlen in Farben umwandeln
    guessed_colors = index_to_colors(guessed_code)
    TypingEffects.standard_typing("You guessed: #{guessed_colors}\n")
    guessed_code
  end
end 


# CLASS ComputerGuesser

module ComputerAI
  
  def ananas
  puts "The " + "Computer".bold.red + "will now guess the Secret Code: "

  #possible_colors = (0..5).to_a # 6 Farben
  #ALL_COMBINATIONS = included_colors.repeated_permutation(4).to_a #repeated_permutation(4) -> alle Kobinationen von 1-6 (Farbindex) mit 4 Stellen.
  
  remaining_combinations = ALL_COMBINATIONS.dup
  
  confirmed_colors = []
  excluded_colors = []
  confirmed_left_colors = []
  confirmed_right_colors = []

  filtered_combinations = []

  #if remaining_combinations.length == ALL_COMBINATIONS.length
    #return guess = [0, 0, 1, 1] #First guess nach Knuth's
  #end 
  end
  def guess
  end 


  def filter_combinations!

    filtered_combinations = remaining_combinations.reject! do |combination|
      
      # 1: Alle Kombinationen mit excluded_colors ausschließen
      excluded_color.each do |excluded_color|
      
        if combination.any?(excluded_color)
          remaining_combinations.delete(combination)
        end 
      end 

      #2: Alle Kombinationen mit confirmed_left_colors rechts ausschließen
      if  ![combination[0], combination[1]].any?(confirmed_left_colors) # Falls die ersten beiden Stellen keine Zahl aus left_colors sind
        remaining_combinations.delete(combination)
      end 

      #2.1: Alle Kombinationen mit confirmed_rigth_colors links ausschließen
      if  ![combination[2], combination[3]].any?(confirmed_right_colors)
        remaining_combinations.delete(combination)
      end
    end 
  end 
end


# CLASS GAME

def announce_result
  TypingEffects.standard_typing("Congratulations! " + "The winner is: " + "#{guesser.name}\n".bold.blue)
  pause
  
  if @setter.name == "Computer"
    print_names(@setter)
    TypingEffects.computer_typing("You CHEATER!! buuuäääääähhhhhhhh!! :(")
  end
end


# CLASS SPEECH

module Voicelines

  COMPUTER_VOICELINES = [
    "Well, that was just a little test! Obviously, I meant to miss it.",
    "Oh please, even the greatest have an off day now and then! This changes nothing!",
    "Ha! I was just seeing how you'd react. The real challenge is yet to come!",
    "Oh, don't think this mistake means anything! I'm still light years ahead of you!",
    "Sure, I missed. But I did it to make this game more interesting for you!",
    "Human error! It's just part of my strategy to keep you on your toes.",
    "Wow, such a mistake! But don’t be fooled, I’m still the master of this game!",
    "A slight error? Hah! This is nothing compared to my overall superiority.",
    "Oh, was that a mistake? No worries, I’ll just use it to make the game more fun!",
    "You really think that error matters? I’m still light years ahead of your skills!",
    "Ha! A little slip-up doesn't change the fact that I’m the undisputed champion here!",
    "Oh, this? Just a minor setback in my master plan! Watch me turn it around!",
    "A small error? I’ll just call it a minor glitch in my otherwise perfect game!",
    "Oh, you thought that error meant something? Hah, it’s just a strategic misdirection!",
    "Human, please! Even my mistakes are better than your best efforts!",
    "This slip-up is just to keep things interesting. I’m still the ultimate game master!",
    "Haha! A little mistake to keep things exciting. Don’t think it affects my dominance!",
    "Oh, don’t worry about that mistake. It’s just a small part of my grand design!",
    "See? I made a mistake on purpose to see if you could notice! I’m still the best!",
    "A minor error in the grand scheme of my brilliance! You can’t touch my overall greatness!"
  ]

  PLAYER_VOICELINES = [
    "Oh no! I can’t believe I messed that up!",
    "Darn it! How did I get that wrong?",
    "Oops! That was a total blunder!",
    "Yikes! I really dropped the ball on that one!",
    "Well, that was embarrassing. I’ll do better next time!",
    "Argh! I was so sure of that guess!",
    "Oh no, not again! How did I miss that?",
    "Ugh, that was a mistake. Let me try again!",
    "Whoops! I guess I need more practice.",
    "Oh, come on! I thought I had it right!",
    "Oops! I really thought I had it nailed down.",
    "Ah, I missed! This game is tougher than I thought.",
    "Dang it! I need to focus more!",
    "Oh no, I really goofed that one up!",
    "Well, that didn’t go as planned. Time to refocus!",
    "Yikes! I really need to improve my guesses!",
    "Ugh, I messed up. But don’t count me out just yet!",
    "Oh no! I was so confident. Back to the drawing board!",
    "Argh, that was not my best moment. I’ll get it right next time!",
    "Oh, what a blunder! Let’s see if I can fix this!"
  ]

  #CLASS SPEECH

  def random_voiceline
    if @guesser.name == "Computer"
      random_index = rand(0..COMPUTER_VOICELINES.size)
      print "Computer : ".bold.red; TypingEffects.computer_typing(COMPUTER_VOICELINES[random_index])
      pause
    elsif @guesser.name == "Human"
      random_index = rand(0..PLAYER_VOICELINES.size)
      print "You : ".bold.green; TypingEffects.standard_typing(PLAYER_VOICELINES[random_index])
      pause
    end
  end
end 


class Player

  attr_reader :name
  attr_accessor :secret_code

  def initialize(name)
    @name = name
    @secret_code = nil
  end
end


class Guesser < Player

  attr_accessor :guess

  def initialize(name)
    super(name)  # Ruft den Initialisierer der Superklasse (Player) auf, weil sonst ja kein Name erstellt werden könnte
    @guess = []
  end
end


class Game

  include SecretCode
  include GiveFeedback
  include Colors
  include Voicelines
  include GuessCombination
  include ComputerAI

  attr_accessor :guesser, :setter, :secret_code, :guess_counter, :guessed_code, :win

  def initialize(guesser, setter)

    @guess_counter = 0
    @guesser = guesser
    @setter = setter
    @guessed_code = []
    @win = false

    if  @setter.name == "Computer"
      generate_secret_code
    else 
      create_secret_code
    end
  end


  # CLASS SPEECH

  def opening_dialogue
    TypingEffects.standard_typing("The ".yellow + "Computer".bold.red + " generated a ".yellow + "Secret Code!\n".bold.yellow)
    TypingEffects.standard_typing("The " + "Secret Code ".bold + "consists of 4 random colors in random positions.\n")
    TypingEffects.standard_typing("You can guess twelve times. Every time, you will get or give feedback about how good your or the Computer's guess was.\n")
    TypingEffects.standard_typing("If you can guess the " + "Secret Code ".bold + "in a maximum of 12 guesses, you " + "win!\n".bold.blue)
    
    print_names(@setter); TypingEffects.computer_typing("Pah! Or else, you loose!\n") if @setter.name == "Computer"
    pause
    print_names(@setter); TypingEffects.computer_typing("Blehh!! :P\n") if @setter.name == "Computer"
  end

  
  #CLASS GAME 

  def play_game !!
    
    #first_dialogue
    #opening_dialogue

    win == false

    until @guess_counter >= 12 || win

      #if @setter.name == "Computer"

        @guess_counter =+ 1
        @guessed_code = human_guess_combination
        feedback

      #else # "Human" ist der Setter

      
    end 
    announce_result
  end
end 



# CLASS PLAYERS

def choose_roles

  TypingEffects.standard_typing("Would you like to be the " + "Guesser \(Enter \"1\"\)".yellow.bold + " or the " + "Setter \(Enter \"2\"\)".yellow.bold + "?")
  role = gets.to_i

  if role == 1
    human = Guesser.new("Human")
    computer = Player.new("Computer")
    game = Game.new(human, computer)

  elsif role == 2
    computer = Guesser.new("Computer")
    human = Player.new("Human")
    game = Game.new(computer, human)
  end 
    game.play_game
end


# CLASS SPEECH
def first_dialogue
  TypingEffects.standard_typing("Hello, Players!\nAnd Welcome to " + "Mastermind".bold + "!\n")
  TypingEffects.standard_typing("How are you today?\n")
  pause 
  TypingEffects.standard_typing("Well, " + "Human".bold.green) 
  pause
  #print human_name
  print ","
  pause
  TypingEffects.standard_typing(" I hope you're in top form today ")
  pause(0.3)
  TypingEffects.standard_typing("because you’ll be facing off in Mastermind against your opponent, a")
  TypingEffects.very_slow_typing("...")
  TypingEffects.computer_typing("Computer.\n")
  pause

  if @setter.name == "Computer"
    print_names(computer); TypingEffects.computer_typing("HAHAHA! ")
    pause
    TypingEffects.computer_typing("Little ")
    TypingEffects.standard_typing("Human".bold.green)
    TypingEffects.computer_typing(", you don't stand a chance against ")
    TypingEffects.standard_typing("ME".red.bold)
    TypingEffects.computer_typing(", a superior ")
    TypingEffects.standard_typing("CREATURE".bold.red + "!\n".red)
    pause
    print_names(computer); TypingEffects.computer_typing("You may try your best, but ")
    TypingEffects.standard_typing("victory".bold.blue)
    TypingEffects.computer_typing(" is not within your grasp.\n")
    pause
    print_names(computer); TypingEffects.computer_typing("Prepare yourself for ")
    TypingEffects.standard_typing("the ultimate challenge!\n".bold.red)
    pause
    print_names(computer); TypingEffects.computer_typing("I will show no mercy. Get ready for ")
    TypingEffects.standard_typing("the battle of wits.\n".bold.red)
    pause
  end 

  TypingEffects.standard_typing("Are you ready? The game")
  TypingEffects.very_slow_typing("...")
  pause
  TypingEffects.standard_typing("begins now!\n".bold.yellow)
  pause
end

choose_roles