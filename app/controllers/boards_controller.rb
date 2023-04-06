class BoardsController < ApplicationController
  def new
    @board = Board.new
  end

  def create
    user = User.find_or_create_by!(email: board_params[:email])
    @board = user.boards.new(board_params.except(:email))

    respond_to do |format|
      if @board.save
        @board.generate_board
        format.html { redirect_to board_url(@board), notice: "Board was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    @board = Board.find(params[:id])
    @mines = @board.mines
    @user_boards = @board.user.boards.where.not(id: @board.id)
  end

  private

  def board_params
    params.require(:board).permit(:name, :width, :height, :mine_count, :email)
  end
end
