class BoardsController < ApplicationController
  def new
    @board = Board.new
  end

  def create
    user = User.find_or_create_by!(email: board_params[:email])
    @board = user.boards.new(board_params.except(:email))

    if @board.save
      redirect_to board_path(@board)
    else
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  private

  def board_params
    params.require(:board).permit(:name, :width, :height, :mines, :email)
  end
end
