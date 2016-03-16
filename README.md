# Chess

##Implementation Details

Built in Ruby to run in console. Clone this repo and from the root folder run:
    ruby lib/game.rb
to run the game.

Pieces are placed in two categories: stepping and sliding (pawns are handle separately).  Sliding pieces store references to the directions they can travel: horizontal and diagonal.  moves are then generated in the following fashion:
``` ruby
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
```

For each direction the move list keeps adding more moves until the edge of the board or another piece is hit.  If the other piece is an opponent piece that move is also added to the list.


For stepping pieces (knights and kings) the following logic is used:
```ruby
def all_moves
  moves = []
  move_options.each do |x, y|
    cur_move = [@pos[0] + x, @pos[1] + y]
    if board.valid_move?(cur_move)
      if board.empty?(cur_move)
        moves << cur_move
      elsif board[cur_move].color != color
        moves << cur_move
      end
    end
  end
  moves
end
```

All move options are checked.  If it's in bounds and does not contain a piece, the option is added to the array.  Like the sliding pieces, if the there is an opponent piece in the position the position is also added to the move list.


Check and checkmate were also fun to implement.
```ruby
def in_check?(color)
   king_pos = find_king(color).pos
   pieces.any? do |p|
     p.color != color && p.all_moves.include?(king_pos)
   end
 end

 def pieces
   @rows.flatten.reject { |piece| piece.empty? }
 end
```

For check, we first find the king's position on the board.  We then go through all pieces and check to see if their move lists contain the kings position, and if so, that it is the opponent's king.

And then for checkmate

```ruby
def checkmate?(color)
  return false unless in_check?(color)

  pieces.select { |p| p.color == color }.all? do |piece|
    piece.valid_moves.empty?
  end
end
```

First we see that a player is in check.   We then select all the pieces of the correct color and check to see if every move list is empty.  If it is, the player is in checkmate and the game is over.

## Future Features

 -More descriptive feedback for when making an invalid move
 -add in En Passant and Castling
 -add in Promotion and allow the player their choice of Queen, Rook, Bishop or Knight.
