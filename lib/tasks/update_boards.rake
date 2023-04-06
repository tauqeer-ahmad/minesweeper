namespace :boards do
  desc 'Update previously generated boards to work with the new approach'
  task update_boards: :environment do
    boards = Board.includes(:mines).all

    boards.each do |board|
      if board.mines.size.zero? && board.mine_count > 0
        generator = MineGeneratorService.new(board.width, board.height, board.mine_count)
        mine_positions = generator.generate_mines

        mine_positions.each do |x, y|
          Mine.create(board: board, x: x, y: y)
        end

        puts "Updated board #{board.id}"
      end
    end

    puts 'All boards updated'
  end
end
