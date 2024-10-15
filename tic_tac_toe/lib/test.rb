require 'colorize'

human_name =  "Human".green.bold
computer_name = "Computer".red.bold


def pause(time = 0.3)
  sleep(time)
end

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

  def self.scared_typing(string)

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

BOARD = [
  ["1", "2", "3"],
  ["4", "5", "6"],
  ["7", "8", "9"]
]

current_board =  = [
  ["1", "2", "3"],
  ["4", "5", "6"],
  ["7", "8", "9"]
]

WINNING_COMBINATIONS = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]


def win?(board, player)
  WINNING_COMBINATIONS.any? do |combinations|
end


# Ersten Player random entscheiden
  def self.choose_first_player

    decide_randomly = rand(1..2)
  
    if decide_randomly == 1
      first_player = "You".green.bold
      else
      first_player = "Computer".red.bold
      end
  end 

# Board ausgeben

  def self.print_board(board = [["1", "2", "3"],["4", "5", "6"],["7", "8", "9"]])

    board.each_with_index do |row, index|
      
      puts board.join(' | ')

      if index < board.length - 1  #?
        puts "--+---+--"
      end
    end
  end
end



#UNNÖTIG

def find_out_matching_board_index(selected_position)

  BOARD.each_with_index do |row, row_index|
    row.each_with_index do |element, element_index|

      if element == select_position 
        return [row_index, element_index]
      end
    end 
  end 

  puts "No element found." # falls if nicht zutrifft
  nil
end 


def free_position?(board, row_index, element_index)

 # True oder False returnen
  if board[row_index][element_index].to_i.between?(1, 9)
    return true
  else 
    return false
  end 
end


def what_mark(current_player)

  if current_player == "Human"
    mark = "X"
  else
    mark = "O"
  end 
end 


def place_mark!(board, index, mark_type)

  # switchen für jeweils X oder O

  





  def current_player
  end 



  def select_position(current_player)

    if current_player == computer

      computer_ai
      
      else #current_player == human
      puts TypingEffects.narrator2_typing("The following positions are currently available:")
      print_board(rows)
      puts TypingEffects.narrator2_typing("Please select a position.")

      selected_position = gets.chomp.to_i
        
        until selected_position.between?(0, 9) && position_available(select_position)
          puts "The selected position is unavailable. Please choose an available position: "
          selected_position = gets.chomp.to_i
        end 

      puts TypingEffects.narrator2_typing("You selected the position: #{selected_position}")

      def selected_position_to_index(selected position)


      rows << "X"[selected_position][index]
    end 





  def whose_turn
  end

  def make_a_move

    TypingEffects.standard_typing("It is your turn, ")
    print first_player
    puts

    TypingEffects.standard_typing("")

  end 

  def move(character, move_index)

  end
  
  loop do |player, computer|
    break
  end


  if win?

    def choose_computer_voiceline
    
    TypingEffects.standard_typing("#{line}")




    def free_position?(board, row_index, element_index)
      board[row_index][element_index].to_i.between?(1, 9)
    end 
  
    def place_mark!(board, chosen_field)

      board.each_with_index do |row, row_index|   #muss nicht abgefragt werden
        row.each_with_index do |element, element_index|
    
          if element == chosen_field
            board[row_index][element_index] = @mark_type
          end
        end
      end



      module ChooseAndCheckMarkPlacement

        def valid_mark_placement?(board)
      
        loop do 
      
          TypingEffects.narrator2_typing("Please chose a free field between (1-9) to place your mark \(#{@mark_type}\) in: ")
          chosen_field = gets.chomp.to_i
      
          until chosen_field.between?(1, 9) && element = chosen_field
      
            board.each_with_index do |row, row_index|
              row.each_with_index do |element, element_index|
      
                chosen_field = gets.chomp.to_i
                puts "Your input is invalid or the field is already taken. Please try again."
      
              end
            end 
          end 
      
          place_mark!(board, row_index, element_index)
      
        end 
      end 
              
              
          
      module ChooseAndCheckMarkPlacement
      
        def valid_mark_placement?(board)
      
          TypingEffects.narrator2_typing("Please chose a free field between (1-9) to place your mark \(#{@mark_type}\) in: ")
          chosen_field = gets.chomp.to_i
      
          # Prüfen, ob die Zahl im Board vorhanden ist (-> frei ist)
          until board.flatten.include?(chosen_field.to_s)
      
          puts "Your input is invalid or the field taken. Please choose a field between (1-9): " 
            chosen_field = gets.chomp.to_s
      
            board.each_with_index do |row, row_index|
              row.each_with_index do |element, element_index|
      
                if element == chosen_field
                  board[row_index][element_index] = @mark_type
                end
              end
            end  
          end 
      
      
          module CheckAndChooseMarkPlacement
            def choosing_mark_placement(board)
          
              TypingEffects.narrator2_typing("Please chose a free field between (1-9) to place your mark \(#{@mark_type}\) in: ")
              chosen_field = gets.chomp
          
              until !invalid_mark_placement?
                board.flatten.include?(chosen_field.to_i)
          
          
                
                board.each_with_index do |row, row_index|
                  row.each_with_index do |element, element_index|
          
                    if element == chosen_field
                      !invalid_mark_placement
                      place_mark!(board, row_index, element_index)
                    end
                  end
                end 
              end 
            end
          
            def valid_mark_placement?(board, chosen_field)
          
              until board.flatten.include?(chosen_field.to_i)
          
                puts "Your input is invalid or the field is already taken. Please try again."
                chosen_field = gets.chomp.to_i
              end 
            end 
          end 
          








    end
  end



def opening_dialogue
  # opening_dialogue

  TypingEffects.standard_typing("Hello, ")
  print human_name
  TypingEffects.standard_typing("!!!")
  puts
  pause(0.7)
  TypingEffects.standard_typing("How are you today?")
  pause
  puts 
  TypingEffects.standard_typing("Well, ") 
  pause
  print human_name
  print ","
  pause
  TypingEffects.standard_typing(" I hope you're in top form today ")
  pause(0.3)
  TypingEffects.standard_typing("because you’ll be facing off in Tic-Tac-Toe against your opponent, a")
  TypingEffects.very_slow_typing("...")
  TypingEffects.evil_typing("Computer.")
  puts
  pause

  # Computer speaks
  print computer_name + ":"
  TypingEffects.standard_typing("\"Ah, so you think you can win against ")
  print "ME".red.bold
  pause
  TypingEffects.standard_typing(" little human?\"")
  puts
  pause(1)
  print computer_name + ":"
  TypingEffects.standard_typing("\"I will enjoy watching you fail...\"".bold)
  puts
  pause

  # Player speaks
  print human_name + ":"
  TypingEffects.standard_typing(" \"eeek!!\"")

  pause(2)
  puts 
  TypingEffects.slow_steady_typing("...")
  puts
  TypingEffects.standard_typing("Oh? ")
  pause(1)
  TypingEffects.standard_typing("Was that")
  TypingEffects.slow_steady_typing("..")
  TypingEffects.standard_typing("you?")
  pause
  puts

  TypingEffects.standard_typing("Don't worry ")
  pause
  TypingEffects.standard_typing(":)")
  puts
  pause
  TypingEffects.standard_typing("It's just a little game. " )
  pause
  TypingEffects.standard_typing("I'm sure, ")
  pause
  TypingEffects.standard_typing("you'll do great." )
  pause
  puts
  TypingEffects.standard_typing("You might just need to")
  pause(0.6)
  TypingEffects.slow_steady_typing("...")
  pause
  TypingEffects.standard_typing(" to think a BIT" )
  pause(0.8)
  TypingEffects.slow_steady_typing("!")
  pause
  puts
  TypingEffects.standard_typing("But hey, ")
  pause
  TypingEffects.standard_typing("you've got this!")
  pause
  puts
  TypingEffects.narrator2_typing("(Unfortunately, ")
  pause(0.1)
  TypingEffects.narrator2_typing("the Narrator is not convinced about you.)")
  puts
  pause(1.5)


  TypingEffects.standard_typing("Uhm..")
  pause
  TypingEffects.standard_typing("yeah, anyways. ")
  pause(1)
  TypingEffects.standard_typing("Let's start the ")
  print "Game".bold << "!"
  pause(2)
  puts

  # Dialogue: Choosing the first Player

  first_player = self.choose_first_player

  TypingEffects.standard_typing("Who will begin? Let's find out. ")
  pause
  puts
  TypingEffects.standard_typing("Calculating")
  TypingEffects.very_slow_typing("...")
  pause(2)


  TypingEffects.standard_typing("Calculation finished!")
  pause
  puts
  TypingEffects.standard_typing("The first player will be: ") 
  print first_player
  puts
  pause

  if first_player == "Computer".red.bold
  print "Computer: ".red.bold
  TypingEffects.standard_typing("\"HA HA HA!! This will be your DONWFALL!")
  end

  TypingEffects.standard_typing("The symbol for the #{human_name} player is X, while the symbol for the #{computer_name} is O")
end