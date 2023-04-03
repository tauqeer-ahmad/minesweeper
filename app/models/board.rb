class Board < ApplicationRecord
  belongs_to :user

  validates :name, :width, :height, :mines, presence: true
  validates :width, :height, :mines, numericality: { only_integer: true, greater_than: 0 }
  validate :mines_less_than_total_cells

  def mines_less_than_total_cells
    if mines.present? && width.present? && height.present? && mines >= width * height
      errors.add(:mines, "must be less than total cells")
    end
  end
end
