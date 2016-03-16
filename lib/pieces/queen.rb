require_relative 'piece'
require_relative 'sliding_pieces'

class Queen < Piece
  
  include SlidingPieces

  def symbol
    '♛'.colorize(color)
  end

  protected

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end
end
