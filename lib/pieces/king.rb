require_relative 'piece'
require_relative 'stepping_pieces'

class King < Piece
  SCORE = 0

  include SteppingPieces

  def symbol
    '♚'.colorize(color)
  end

  def move_options
    [[-1, -1],
     [-1, 0],
     [-1, 1],
     [0, -1],
     [0, 1],
     [1, -1],
     [1, 0],
     [1, 1]]
  end
end
