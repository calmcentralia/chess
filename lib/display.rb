require "colorize"
require_relative "cursorable"

class Display
  include Cursorable

  attr_reader :board, :notifications

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @notifications = {}
  end

  def make_grid
    grid = Array.new(8) { Array.new(8) }
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |piece, j|

        if [i, j] == @cursor_pos
          bg = :light_yellow
        elsif (i + j).odd?
          bg = :light_blue
        else
          bg = :light_red
        end
        grid[i][j] = piece.to_s.colorize({ background: bg })
      end
    end
    grid
  end

  def render
   system("clear")
   puts "Arrow keys or WASD to move, space or enter to confirm."
   make_grid.each { |row| puts row.join }
  end
end
