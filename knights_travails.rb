# frozen_string_literal: true

# Chess board
board = [
  %w[[0,7] [1,7] [2,7] [3,7] [4,7] [5,7] [6,7] [7,7]],
  %w[[0,6] [1,6] [2,6] [3,6] [4,6] [5,6] [6,6] [7,6]],
  %w[[0,5] [1,5] [2,5] [3,5] [4,5] [5,5] [6,5] [7,5]],
  %w[[0,4] [1,4] [2,4] [3,4] [4,4] [5,4] [6,4] [7,4]],
  %w[[0,3] [1,3] [2,3] [3,3] [4,3] [5,3] [6,3] [7,3]],
  %w[[0,2] [1,2] [2,2] [3,2] [4,2] [5,2] [6,2] [7,2]],
  %w[[0,1] [1,1] [2,1] [3,1] [4,1] [5,1] [6,1] [7,1]],
  %w[[0,0] [1,0] [2,0] [3,0] [4,0] [5,0] [6,0] [7,0]]
]

def knight_moves(start_square, end_square)
  knight = Tree.new(Node.new(start_square))
  knight.travail
  knight.root
end

# Knight next possible moves from starting square
class Node
  attr_accessor :data, :moves

  def initialize(data)
    @data = data
    @moves = []
  end
end

# Knight tree
class Tree < Node
  attr_reader :root

  def initialize(root)
    @root = root
  end

  # Gets all possible moves from starting point (square)
  def travail(square = @root)
    square.moves.push Node.new(right(square.data, 'up')),
                      Node.new(right(square.data, 'down')),
                      Node.new(left(square.data, 'up')),
                      Node.new(left(square.data, 'down')),
                      Node.new(up(square.data, 'right')),
                      Node.new(up(square.data, 'left')),
                      Node.new(down(square.data, 'right')),
                      Node.new(down(square.data, 'left'))

    square.moves = square.moves.reject { |move| move.data.nil? }
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
