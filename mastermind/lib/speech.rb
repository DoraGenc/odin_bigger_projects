require 'colorize'

module TypingEffects

  def pause(time = 0.3)
    sleep(time)
  end 
  
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


module Speech

  include TypingEffects
  
  def pause(time = 0.3)
    sleep(time)
  end
  
  def opening_dialogue
    TypingEffects.standard_typing("The ".yellow + "Computer".bold.red + " generated a ".yellow + "Secret Code!\n".bold.yellow)
    TypingEffects.standard_typing("The " + "Secret Code ".bold + "consists of 4 random colors in random positions.\n")
    TypingEffects.standard_typing("You can guess twelve times. Every time, you will get or give feedback about how good your or the Computer's guess was.\n")
    TypingEffects.standard_typing("If you can guess the " + "Secret Code ".bold + "in a maximum of 12 guesses, you " + "win!\n".bold.blue)
    
    print_names(@setter); TypingEffects.computer_typing("Pah! Or else, you loose!\n") if @setter.name == "Computer"
    pause
    print_names(@setter); TypingEffects.computer_typing("Blehh!! :P\n") if @setter.name == "Computer"
  end

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

  private 
  
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
end 