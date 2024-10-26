class Wordpicker

  def initialize
    @file_path = '../lib/google-10000-english-no-swears.txt'
  end

  def pick_word
    random_line_index = rand(0..10000)
    random_word = File.readlines(file_path)[random_line_index].chomp

    random_word
  end

  private
  attr_reader :file_path
end
