require_relative 'board'
require 'yaml'

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
      puts "Reveal, flag, unflag, or save? [r/f/u/s]"
      option = gets.chomp
      if option == "r"
        won = @board.reveal(position)
        break unless won
      elsif option == "f"
        @board[position].flag
      elsif option == "u"
        @board[position].unflag
      else
        save
        won = "saved"
        break
      end
      # break unless won
    end

    if won == "saved"
      puts "Game saved!"
    elsif won
      puts "You win!"
    else
      puts "You lose!"
    end

  end

  def save
    puts "Enter filename to save at:"
    filename = gets.chomp

    File.write(filename, self.to_yaml)
  end

  def game_over?
    @board.mine_locations.all? { |location| @board[location].flagged? }
  end
end


if $PROGRAM_NAME == __FILE__

  case ARGV.count
  when 0
    Minesweeper.new.play
  when 1
    YAML.load_file(ARGV.shift).play
  end
end
