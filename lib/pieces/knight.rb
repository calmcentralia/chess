require_relative 'piece'
require_relative 'stepping_pieces'

class Knight < Piece
  SCORE = 3

  include SteppingPieces

  def symbol
    '♞'.colorize(color)
  end


  def move_options
    [[-2, -1],
     [-1, -2],
     [-2, 1],
     [-1, 2],
     [1, -2],
     [2, -1],
     [1, 2],
     [2, 1]]
  end
end
