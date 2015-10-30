class Board
  def initialize
    @board = Array.new(9) {Array.new(9)}
    mine_locations = randomize_mines
    populate_board(mine_locations)
  end

  def randomize_mines
    number_mines = 10
    positions = []
    while positions.length <= number_mines
      x = (0..9).to_a.sample
      y = (0..9).to_a.sample
      positions << [x,y] unless positions.include?([x,y])
    end
    positions
  end

  def populate_board(mine_locations)
    @board.each do |row|
      row.map! do |position|
        if mine_locations.include?(position)
          Tile.new(true)
        else
          Tile.new(nil)
        end
      end
    end
  end

end
