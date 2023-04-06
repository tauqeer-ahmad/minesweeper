require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_board_url
    assert_response :success
  end

  test "should create board" do
    assert_difference('Board.count', 1) do
      post boards_url, params: { board: { email: 'test@example.com', name: 'Test Board', width: 10, height: 10, mine_count: 10 } }
    end
    assert_redirected_to board_path(Board.last)
  end

  test "should not create board with invalid data" do
    assert_no_difference('Board.count') do
      post boards_url, params: { board: { email: 'test@example.com', name: '', width: 10, height: 10, mine_count: 10 } }
    end
    assert_response :unprocessable_entity
  end

  test "should show board" do
    board = boards(:one)
    get board_url(board)
    assert_response :success
  end
end
