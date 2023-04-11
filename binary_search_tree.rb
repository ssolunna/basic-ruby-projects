# frozen_string_literal: true

# Nodes of the Tree
class Node
  def initialize(data, left, right)
    @data = data
    @left = left
    @right = right
  end
end

# Binary Search Tree
class Tree
  attr_reader :array, :root

  def initialize(array)
    @array = array
    @root = build_tree(array.uniq.sort)
  end
end

# Turns a sorted array (without duplicate elements)
# into a balanced binary tree
def build_tree(array)
  return if array.empty?

  mid = (0 + array.size - 1) / 2
  left = build_tree(array[0...mid])
  right = build_tree(array[mid + 1...array.size])

  Node.new(array[mid], left, right)
end
