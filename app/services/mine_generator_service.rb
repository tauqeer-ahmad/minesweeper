class MineGeneratorService
  attr_reader :width, :height, :mines

  def initialize(width, height, mines)
    @width = width
    @height = height
    @mines = mines
  end

  def generate_mines
    positions = (0...width * height).to_a
    mine_positions = []

    mines.times do |i|
      random_index = i + rand(positions.length - i)
      mine_positions << positions[random_index]
      positions[random_index] = positions[i]
    end

    mine_positions.map { |pos| [pos % width, pos / width] }
  end
end
