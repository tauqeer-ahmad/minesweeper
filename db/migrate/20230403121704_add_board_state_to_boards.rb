class AddBoardStateToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :board_state, :text
  end
end
