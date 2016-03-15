require_relative 'board'
require_relative 'human_player'

class Game
  attr_reader :board, :display, :current_player, :players

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {
      white: HumanPlayer.new(:white, @display),
      black: HumanPlayer.new(:black, @display)
    }

    @current_player = :white
  end

  def play
    until board.checkmate?(current_player)
      valid = false
      until valid
        positions =  players[current_player].make_move(board)
        valid = true unless board.move_piece(current_player, positions[0], positions[1]).nil?
      end
      swap
    end
    display.render
    puts "#{current_player} is in checkmate.  Good Game!"
  end

  def swap
    @current_player = current_player == :white ? :black : :white

  end
end
if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
