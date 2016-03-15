require_relative 'piece'
require_relative 'sliding_pieces'

class Bishop < Piece
  SCORE = 3

  include SlidingPieces

  def symbol
    '♝'.colorize(color)
  end

  def move_dirs
    diagonal_dirs
  end
end
