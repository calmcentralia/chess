require_relative 'piece'

class Pawn < Piece

  def symbol
    '♟'.colorize(color)
  end

  def direction
    if color == :white
      -1
    else
      1
    end
  end

  def all_moves
    step_moves + attacks
  end

  def unmoved?
    if color == :white
      pos[0] == 6
    else
      pos[0] == 1
    end
  end

  def step_moves
    step = [direction + pos[0], pos[1]]
    return [] unless board.valid_move?(step) && board.empty?(step)
    steps = [step]
    step_two = [direction*2 + pos[0], pos[1]]
    steps << step_two if board.valid_move?(step_two) && board.empty?(step_two) && unmoved?
    steps
  end

  def attacks
    moves = [[direction + pos[0], pos[1] - 1], [direction + pos[0], pos[1] + 1]]
    valid_moves = []

    moves.each do |move|
      other_piece = board[move]
      valid_moves << move if board.valid_move?(move) && !board.empty?(move) && other_piece && other_piece.color != color
    end
    valid_moves
  end
end
