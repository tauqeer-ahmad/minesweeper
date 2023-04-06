class Board < ApplicationRecord
  belongs_to :user
  has_many :mines, dependent: :destroy

  validates :name, :width, :height, :mine_count, presence: true
  validates :width, :height, :mine_count, numericality: { only_integer: true, greater_than: 0 }
  validate :mines_less_than_total_cells

  def mines_less_than_total_cells
    if mine_count.present? && width.present? && height.present? && mine_count > width * height
      errors.add(:mine_count, "must be less or equal to total cells")
    end
  end

  def generate_board
    generator = MineGeneratorService.new(self.width, self.height, self.mine_count)
    mine_positions = generator.generate_mines

    mines = mine_positions.map { |x, y| Mine.new(board: self, x: x, y: y) }
    Mine.import mines, validate: false
  end
end
