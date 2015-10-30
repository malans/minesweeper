class Tile
  attr_accessor :mine_count

  def initialize(has_mine)
    @revealed = nil
    @flagged = nil
    @mine = has_mine
    @mine_count = 0
  end

  def has_mine?
    @mine
  end

  def neighbor_mine_count

  end
end
