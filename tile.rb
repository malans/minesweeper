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

  def revealed?
    @revealed
  end

  def reveal
    @revealed = true
    mine_count
  end

  def flag
    @flagged = true
  end

  def flagged?
    @flagged
  end

  def unflag
    @flagged = nil
  end
end
