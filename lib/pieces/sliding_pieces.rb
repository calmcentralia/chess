module SlidingPieces

  def horizontal_dirs
    [[-1, 0],
    [0, -1],
    [0, 1],
    [1, 0]]
  end

  def diagonal_dirs
    [[-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]]
  end

  def all_moves
    moves = []
    move_dirs.each do |x, y|
      moves.concat(all_options_in_dir(x, y))
    end
    moves
  end

  def all_options_in_dir(x, y)
    moves = []
    curr_move = [@pos[0]+ x, @pos[1] + y]
    while board.valid_move?(curr_move)
      if board.empty?(curr_move)
        moves << curr_move
      else
        moves << curr_move if board[curr_move].color != color
        break
      end
      curr_move = [curr_move[0] + x, curr_move[1] + y]
    end
    moves
  end
end
