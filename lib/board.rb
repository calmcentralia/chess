require_relative 'pieces'

class Board
  attr_reader :rows

  def initialize(to_fill = true)
    make_grid(to_fill)
  end

  def make_grid(to_fill)
    @rows = Array.new(8) { Array.new(8, NullPiece.new) }
    return unless to_fill
    back_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ]
    back_pieces.each_with_index do |piece_class, j|
      @rows[7][j] = piece_class.new(:white, self, [7, j])
      @rows[0][j] = piece_class.new(:black, self, [0, j])
    end

    8.times do |j|
      @rows[6][j] = Pawn.new(:white, self, [6, j])
      @rows[1][j] = Pawn.new(:black, self, [1, j])
    end
  end

  def [](pos)
    i, j = pos
    @rows[i][j]
  end

  def []=(pos, piece)
    i, j = pos
    @rows[i][j] = piece
  end

  def add_piece(piece, pos)
    @rows[pos[0]][pos[1]] = piece;
  end

  def checkmate?(color)
    return false unless in_check?(color)

    pieces.select { |p| p.color == color }.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def dup
   new_board = Board.new(false)

   pieces.each do |piece|
     piece.class.new(piece.color, new_board, piece.pos)
   end

   new_board
 end

 def empty?(pos)
   self[pos].empty?
 end

 def in_check?(color)
    king_pos = find_king(color).pos
    pieces.any? do |p|
      p.color != color && p.all_moves.include?(king_pos)
    end
  end

  def pieces
    @rows.flatten.reject { |piece| piece.empty? }
  end

  def valid_move?(pos)
    pos.all? do |coord|
      coord <= 7 && coord >=0
    end
  end

  def move_piece(turn_color, from_pos, to_pos)
    raise 'from position is empty' if empty?(from_pos)

    piece = self[from_pos]
    if piece.color != turn_color
      raise 'You have to move your own piece'
    elsif !piece.all_moves.include?(to_pos)
      raise 'Not a valid move'
    elsif !piece.valid_moves.include?(to_pos)
      raise 'You cannot move into check'
    end

    move_piece!(from_pos, to_pos)
  end

  def move_piece!(current, final)
    piece = self[current]
    self[final] = piece
    self[current] = NullPiece.new
    piece.pos = final
    nil
  end

  def find_king(color)
    king_pos = pieces.find { |piece| piece.color == color && piece.is_a?(King) }
    king_pos
  end
end
