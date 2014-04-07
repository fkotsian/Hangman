# Hangman.rb
# Version 2, redux
# By: Frank def Kotsianas
# App Academy Week 1 Day 6

class Game
  attr_accessor :guessing_player, :picking_player, :word_length, :guessed_letters, :guess_progress

  def initialize(guessing_player = :human, comp_player, human_player)
    @guessed_letters = []
    @guess_progress = ""

    if guessing_player == :human
      @guessing_player = human_player
      @picking_player = comp_player
    else
      @guessing_player = comp_player
      @picking_player = human_player
    end

    set_mystery_word_length
    # play_game


  end

  def set_mystery_word_length
    self.word_length = picking_player.pick_mystery_word
    self.guess_progress = "_" * word_length
  end

  def display_word
    puts "The word so far is: #{self.guess_progress}"
  end

  def play_game
    puts "The game is starting! Your word is: #{self.guess_progress}"

    until !self.guess_progress.include?("_")
      puts "So far, the guessed letters are: #{self.guessed_letters}."
      current_guess = guessing_player.make_guess
      self.guessed_letters << current_guess
      letter_locs = picking_player.handle_guess( current_guess )

      # update guess progress
      letter_locs.each do |index|

        self.guess_progress[index] = current_guess
      end

      display_word
    end
    puts "You win! The word was: #{self.guess_progress}, and you guessed in #{self.guessed_letters.length} guesses."
  end

end

class HumanPlayer
  attr_accessor :role

  def initialize(role=:guesser)
    @role = role
  end

  def make_guess
    print "Guess a letter: "
    guess = gets.chomp
  end

  def pick_mystery_word
    #puts
    #gets
  end

end

class ComputerPlayer
  attr_accessor :role, :dict, :picked_word

  def initialize(role = :picker, dict_loc = "./dictionary.txt")
    @role = role
    @dict = File.readlines(dict_loc).map(&:chomp)
  end

  # will return the length of the picked word
  def pick_mystery_word
    @picked_word = self.dict.sample
    self.picked_word.length
  end

  # guesses random word of appropriate length
  def guess_word(word_length)
    self.sample(dict.select { |word| word.length == word_length } )
  end

  def handle_guess( guess )
    guess_locations = []

    if self.picked_word.include?( guess )
      # picked_word_arr = self.picked_word.split("")

      0.upto(self.picked_word.length-1) do |index|
        guess_locations << index if self.picked_word[index] == guess
      end

    end
    guess_locations
  end

end




















