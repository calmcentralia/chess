require "byebug"
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
    @pos = [@pos[0]+ x, @pos[1] + y]
    while board.valid_move?(pos)
      if board.empty?(pos)
        moves << pos
      else
        moves << pos if board[pos].color != color
        break
      end
      @pos = [@pos[0] + x, @pos[1] + y]
    end
    moves
  end
end
