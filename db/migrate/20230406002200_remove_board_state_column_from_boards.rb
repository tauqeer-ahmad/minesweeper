class RemoveBoardStateColumnFromBoards < ActiveRecord::Migration[7.0]
  def change
    remove_column :boards, :board_state
  end
end
