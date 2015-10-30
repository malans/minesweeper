class Tile
  def initialize(has_mine)
    @revealed = nil
    @flagged = nil
    @bomb = has_mine
  end
end
