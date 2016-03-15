require 'singleton'

class Piece
  attr_reader :board, :color
  attr_accessor :pos

  def initialize(color, board, pos)

    @color, @board, @pos = color, board, pos

    board.add_piece(self, pos)
  end

  def to_s
    " #{symbol} "
  end

  def empty?
    false
  end


  def valid_moves
    all_moves.reject { |to_pos| move_into_check?(to_pos) }
  end


  def move_into_check?(to_pos)
    test_board = board.dup
    test_board.move_piece!(pos, to_pos)
    test_board.in_check?(color)
  end
end

class NullPiece
  def initialize
  end

  def moves
    []
  end

  def color
    :none
  end

  def to_s
    "   "
  end

  def empty?
    true
  end
end
