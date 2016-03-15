module SteppingPieces

  # def all_moves
  #   moves = []
  #   move_options.each do |x, y|
  #     @pos = [@pos[0] + x, @pos[1] + y]
  #     if board.valid_move?(@pos)
  #       if board.empty?(@pos)
  #         moves << @pos
  #       elsif board[@pos].color != color
  #         moves << @pos
  #       end
  #     end
  #   end
  #   moves
  # end
  def all_moves
    moves = []
    move_options.each do |x, y|
      cur_move = [@pos[0] + x, @pos[1] + y]
      if board.valid_move?(cur_move)
        if board.empty?(cur_move)
          moves << cur_move
        elsif board[cur_move].color != color
          moves << cur_move
        end
      end
    end
    moves
  end
end
