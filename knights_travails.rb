# frozen_string_literal: true

# Chess board
#  [0,7] [1,7] [2,7] [3,7] [4,7] [5,7] [6,7] [7,7]
#  [0,6] [1,6] [2,6] [3,6] [4,6] [5,6] [6,6] [7,6]
#  [0,5] [1,5] [2,5] [3,5] [4,5] [5,5] [6,5] [7,5]
#  [0,4] [1,4] [2,4] [3,4] [4,4] [5,4] [6,4] [7,4]
#  [0,3] [1,3] [2,3] [3,3] [4,3] [5,3] [6,3] [7,3]
#  [0,2] [1,2] [2,2] [3,2] [4,2] [5,2] [6,2] [7,2]
#  [0,1] [1,1] [2,1] [3,1] [4,1] [5,1] [6,1] [7,1]
#  [0,0] [1,0] [2,0] [3,0] [4,0] [5,0] [6,0] [7,0]

# Knight next possible @moves from starting Square (@data)
class Square
  attr_accessor :data, :moves

  def initialize(data)
    @data = data
    @moves = []
  end
end

# Knight @board of all possible moves
class Board < Square
  attr_reader :board

  def initialize(start)
    @board = [start]
  end

  # Creates @board with all possible moves the Knight can make
  def create(queue = [*@board])
    return @board if queue.empty?

    square = queue.first

    square.moves.push up(square.data, 'right'),
                      up(square.data, 'left'),
                      left(square.data, 'up'),
                      left(square.data, 'down'),
                      right(square.data, 'up'),
                      right(square.data, 'down'),
                      down(square.data, 'right'),
                      down(square.data, 'left')

    square.moves.compact!

    square.moves.each do |move|
      next if @board.find { |square| square.data == move }

      move = Square.new(move)
      @board.push(move)
      queue.push(move)
    end

    queue.shift
    create(queue)
  end

  def right(current_square, side)
    new_square = if side == 'up'
                   [current_square[0] + 2, current_square[1] + 1]
                 else
                   [current_square[0] + 2, current_square[1] - 1]
                 end

    return nil if new_square.any? { |element| element.negative? || element >= 8 }

    new_square
  end

  def left(current_square, side)
    new_square = if side == 'up'
                   [current_square[0] - 2, current_square[1] + 1]
                 else
                   [current_square[0] - 2, current_square[1] - 1]
                 end

    return nil if new_square.any? { |element| element.negative? || element >= 8 }

    new_square
  end

  def up(current_square, side)
    new_square = if side == 'right'
                   [current_square[0] + 1, current_square[1] + 2]
                 else
                   [current_square[0] - 1, current_square[1] + 2]
                 end

    return nil if new_square.any? { |element| element.negative? || element >= 8 }

    new_square
  end

  def down(current_square, side)
    new_square = if side == 'right'
                   [current_square[0] + 1, current_square[1] - 2]
                 else
                   [current_square[0] - 1, current_square[1] - 2]
                 end

    return nil if new_square.any? { |element| element.negative? || element >= 8 }

    new_square
  end
end

# Knight piece of chess
class Knight
  def initialize(board, target)
    @board = board
    @root = @board[0]
    @target = target
  end

  # Finds the shortest path between the starting square (@root) and the ending square (@target)
  def travail(paths = [[@root.data]])
    path = paths.first

    current_square = @board.find { |square| square.data == path.last }

    current_square.moves.each do |move|
      next if path.include?(move)

      return [*path, move] if move == @target

      paths << [*path, move]
    end

    paths.shift
    travail(paths)
  end
end

# Prints the shortest path between two squares
def knight_moves(start_square, end_square)
  knight_board = Board.new(Square.new(start_square)).create
  knight = Knight.new(knight_board, end_square)
  puts "You made it in #{knight.travail.size - 1} move(s)! Here's your path:"
  knight.travail.each { |move| p move }
end

knight_moves([0,0], [3,3])
puts
knight_moves([3,3], [4,4])
puts
knight_moves([0,0], [7,7])
