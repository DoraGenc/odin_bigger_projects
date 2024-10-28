class Wordpicker

  def initialize
    @file_path = '/Users/dora.genc/Downloads/google-10000-english-no-swears.txt'
  end

  def pick_word
    random_line_index = rand(0..10000)
    random_word = File.readlines(file_path)[random_line_index].chomp

    return random_word
  end

  private
  attr_reader :file_path
end

wordpicker = Wordpicker.new
puts wordpicker.pick_word