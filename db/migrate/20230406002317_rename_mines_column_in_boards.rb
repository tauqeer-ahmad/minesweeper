class RenameMinesColumnInBoards < ActiveRecord::Migration[7.0]
  def change
    rename_column :boards, :mines, :mine_count
  end
end
