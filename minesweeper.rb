require_relative 'board'
require 'byebug'

class Minesweeper
  def initialize
    @board = Board.new
  end

  def play
    until game_over?
      system "clear"
      @board.render
      puts "Enter a position [row, col]"
      position = gets.chomp.split(", ").map(&:to_i)
      puts "Reveal, flag, or unflag? [r/f/u]"
      option = gets.chomp
      if option == "r"
        won = @board.reveal(position)
        break unless won
      elsif option == "f"
        @board[position].flag
      else
        @board[position].unflag
      end
      # break unless won
    end

    if won
      puts "You win!"
    else
      puts "You lose!"
    end

  end

  def game_over?
    @board.mine_locations.all? { |location| @board[location].flagged? }
  end
end


board = Minesweeper.new
board.play
