require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @board = boards(:one)
    @board.user = @user
  end

  test 'valid board' do
    assert @board.valid?
  end

  test 'invalid without width' do
    @board.width = nil
    refute @board.valid?, 'board is valid without a width'
    assert_not_nil @board.errors[:width], 'no validation error for width'
  end

  test 'invalid without height' do
    @board.height = nil
    refute @board.valid?, 'board is valid without a height'
    assert_not_nil @board.errors[:height], 'no validation error for height'
  end

  test 'invalid without name' do
    @board.name = nil
    refute @board.valid?, 'board is valid without a name'
    assert_not_nil @board.errors[:name], 'no validation error for name'
  end

  test 'invalid without user' do
    @board.user = nil
    refute @board.valid?, 'board is valid without a user'
    assert_not_nil @board.errors[:user], 'no validation error for user'
  end

  test 'generate_mines' do
    @board.mines.destroy_all
    @board.save
    @board.generate_board

    assert_equal @board.mine_count, @board.mines.count, 'Incorrect number of mines generated'

    @board.mines.each do |mine|
      assert mine.x.between?(0, @board.width - 1), 'Mine x position is outside the board'
      assert mine.y.between?(0, @board.height - 1), 'Mine y position is outside the board'
    end
  end

  test "should be valid" do
    board = Board.new(user: @user, name: 'Test Board', width: 10, height: 10, mine_count: 10)
    assert board.valid?
  end

  test "should generate board with correct number of mines" do
    @board.width = 10
    @board.height = 10
    @board.mine_count = 10
    @board.mines.destroy_all

    @board.generate_board
    mine_count = @board.mines.count
    assert_equal @board.mine_count, mine_count, "Board has incorrect number of mines"
  end

  test "should generate empty board with zero mines" do
    @board.width = 10
    @board.height = 10
    @board.mine_count = 0
    @board.mines.destroy_all

    @board.generate_board
    mine_count = @board.mines.count
    assert_equal 0, mine_count, "Board should have no mines"
  end

  test "should generate full board with all mines" do
    @board.width = 10
    @board.height = 10
    @board.mine_count = 10
    @board.mines.destroy_all

    @board.generate_board
    mine_count = @board.mines.count
    assert_equal @board.mine_count, mine_count, "Board should have all mines"
  end

  test "should generate board efficiently with high mine-to-cell ratio" do
    @board.width = 100
    @board.height = 100
    @board.mine_count = 10000
    @board.mines.destroy_all
    start_time = Time.now
    @board.generate_board
    end_time = Time.now
    mine_count = @board.mines.count

    assert_equal @board.mine_count, mine_count, "Board has incorrect number of mines"
    assert (end_time - start_time) < 12, "Board generation took too long"
  end

  test "should generate board efficiently with low mine-to-cell ratio" do
    @board.mines.destroy_all
    @board.width = 100
    @board.height = 100
    @board.mine_count = 1
    start_time = Time.now
    @board.generate_board
    end_time = Time.now
    mine_count = @board.mines.count

    assert_equal @board.mine_count, mine_count, "Board has incorrect number of mines"
    assert (end_time - start_time) < 5, "Board generation took too long"
  end

  test "should not allow negative mines" do
    @board.mine_count = -10
    assert_not @board.valid?
  end

  test "should not allow more mines than cells" do
    @board.width = 10
    @board.height = 10
    @board.mine_count = 101
    assert_not @board.valid?
  end
end
