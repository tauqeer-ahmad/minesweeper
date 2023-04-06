module BoardsHelper
  def cell_contains_mine?(x, y, mines)
    mines.any? { |mine| mine.x == x && mine.y == y }
  end
end
