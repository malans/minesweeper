require_relative 'tile'
require 'colorize'

class Board
  attr_reader :mine_locations, :board

  def initialize
    @board = Array.new(9) {Array.new(9)}
    @mine_locations = randomize_mines
    populate_board(@mine_locations)
    assign_values
  end

  def []=(position, value)
    @board[position[0]][position[1]] = value
  end

  def [](position)
    p position
    @board[position[0]][position[1]]
  end

  def randomize_mines
    number_mines = 10
    positions = []
    while positions.length < number_mines
      x = (0..8).to_a.sample
      y = (0..8).to_a.sample
      positions << [x,y] unless positions.include?([x,y])
    end
    positions
  end

  def populate_board(mine_locations)
    @board.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        position = [row_idx, col_idx]
        if mine_locations.include?([row_idx, col_idx])
          self[position] = Tile.new(true)
        else
          self[position] = Tile.new(nil)
        end
      end
    end
  end

  def assign_values
    @board.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        tile.mine_count = count_mines([row_idx, col_idx])
      end
    end
  end

  def count_mines(position)
    mine_count = 0
    (-1..1).to_a.each do |row|
      (-1..1).to_a.each do |col|
        current_position = [position[0] + row, position[1] + col]
        next unless in_bounds?(current_position)
        next if current_position == position
        mine_count += 1 if self[current_position].has_mine?
      end
    end

    mine_count
  end

  def reveal(position)
    return nil if self[position].has_mine?
    if self[position].reveal == 0
      (-1..1).to_a.each do |row|
        (-1..1).to_a.each do |col|
          current_position = [position[0] + row, position[1] + col]
          next unless in_bounds?(current_position)
          next if current_position == position
          reveal(current_position) unless self[current_position].revealed?
        end
      end
    end
    true
  end

  def flag(position)
    self[position].flag
  end

  def render
    puts "  0 1 2 3 4 5 6 7 8"
    @board.each_with_index do |row, row_idx|
      print row_idx
      row.each do |tile|
        if tile.revealed?
          print " #{tile.mine_count}".colorize(:green)
        elsif tile.flagged?
          print " F".colorize(:red)
        else
          print " *".colorize(:green)
        end
      end
      puts
    end

    puts
    puts "solution"

    puts "  0 1 2 3 4 5 6 7 8"
    @board.each_with_index do |row, row_idx|
      print row_idx
      row.each do |tile|
        # if tile.revealed?
        if tile.has_mine?
          print " B"
        else
          print " #{tile.mine_count}".colorize(:green)
        end
        # elsif tile.flagged?
        #   print " F".colorize(:red)
        # else
        #   print " *".colorize(:green)
        # end
      end
      puts
    end
  end

  def in_bounds?(position)
    return position[0].between?(0, 8) && position[1].between?(0, 8)
  end
end
