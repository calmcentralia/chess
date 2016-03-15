require_relative 'display'
require_relative 'player'

class HumanPlayer < Player
  def make_move(board)
    piece_choice = nil
    move_choice = nil
    until piece_choice && move_choice
      display.render
      if piece_choice
        puts "Where do you want to move?"
        move_choice = display.get_input
      else
        puts "It's #{color}'s turn. Which piece would you like to move?"
        piece_choice = display.get_input
      end
    end
    [piece_choice, move_choice]
  end
end
