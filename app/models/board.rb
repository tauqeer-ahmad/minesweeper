class Board < ApplicationRecord
  belongs_to :user

  validates :name, :width, :height, :mines, presence: true
  validates :width, :height, :mines, numericality: { only_integer: true, greater_than: 0 }
  validate :mines_less_than_total_cells
  serialize :board_state

  before_create :generate_board

  def mines_less_than_total_cells
    if mines.present? && width.present? && height.present? && mines >= width * height
      errors.add(:mines, "must be less than total cells")
    end
  end

  def generate_board
    board = Array.new(height) { Array.new(width, '') }
    mines_placed = 0

    while mines_placed < mines
      row = rand(height)
      col = rand(width)

      if board[row][col] == ''
        board[row][col] = '*'
        mines_placed += 1
      end
    end

    self.board_state = board
  end
end
