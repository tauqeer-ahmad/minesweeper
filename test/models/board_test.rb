require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should be valid" do
    board = Board.new(user: @user, name: 'Test Board', width: 10, height: 10, mines: 10)
    assert board.valid?
  end

  test "should generate board with correct dimensions" do
    board = Board.new(user: @user, name: 'Test Board', width: 10, height: 10, mines: 10)

    board.generate_board
    assert_equal board.height, board.board_state.length, "Board has incorrect height"
    assert_equal board.width, board.board_state.first.length, "Board has incorrect width"
  end

  test "should generate board with correct number of mines" do
    board = Board.new(user: @user, name: 'Test Board', width: 10, height: 10, mines: 10)

    board.generate_board
    mine_count = board.board_state.flatten.count('*')
    assert_equal board.mines, mine_count, "Board has incorrect number of mines"
  end

  test "should generate empty board with zero mines" do
    board = Board.new(user: @user, name: 'Test Board', width: 10, height: 10, mines: 0)

    board.generate_board
    mine_count = board.board_state.flatten.count('*')
    assert_equal 0, mine_count, "Board should have no mines"
  end

  test "should generate full board with all mines" do
    board = Board.new(user: @user, name: 'Test Board', width: 10, height: 10, mines: 100)

    board.generate_board
    mine_count = board.board_state.flatten.count('*')
    assert_equal board.mines, mine_count, "Board should have all mines"
  end

  test "should be invalid without user" do
    board = Board.new(user: nil, name: 'Test Board', width: 10, height: 10, mines: 10)
    assert_not board.valid?
  end

  test "should be invalid without name" do
    board = Board.new(user: @user, name: nil, width: 10, height: 10, mines: 10)
    assert_not board.valid?
  end

  test "should be invalid without width" do
    board = Board.new(user: @user, name: 'Test Board', width: nil, height: 10, mines: 10)
    assert_not board.valid?
  end

  test "should be invalid without height" do
    board = Board.new(user: @user, name: 'Test Board', width: 10, height: nil, mines: 10)
    assert_not board.valid?
  end

  test "should be invalid without mines" do
    board = Board.new(user: @user, name: 'Test Board', width: 10, height: 10, mines: nil)
    assert_not board.valid?
  end

  test "should not allow negative width" do
    board = Board.new(user: @user, name: 'Test Board', width: -10, height: 10, mines: 10)
    assert_not board.valid?
  end

  test "should not allow negative height" do
    board = Board.new(user: @user, name: 'Test Board', width: 10, height: -10, mines: 10)
    assert_not board.valid?
  end

  test "should not allow negative mines" do
    board = Board.new(user: @user, name: 'Test Board', width: 10, height: 10, mines: -10)
    assert_not board.valid?
  end

  test "should not allow more mines than cells" do
    board = Board.new(user: @user, name: 'Test Board', width: 10, height: 10, mines: 101)
    assert_not board.valid?
  end
end
