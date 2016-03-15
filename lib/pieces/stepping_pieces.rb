module SteppingPieces

  def all_moves
    moves = []
    move_options.each do |x, y|
      @pos = [@pos[0] + x, @pos[0] + y]
      if board.valid_move?(@pos)
        if board.empty?(@pos)
          moves << @pos
        elsif board[@pos].color != color
          moves << @pos
        end
      end
    end
    moves
  end

end
