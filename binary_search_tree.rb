# frozen_string_literal: true

# Nodes of the Tree
class Node
  attr_reader :data, :left, :right
  protected attr_writer :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

# Binary Search Tree
class Tree < Node
  attr_reader :array, :root

  def initialize(array)
    @array = array
    @root = build_tree(array.uniq.sort)
  end

  # Inserts a leaf Node in the Tree
  def insert(value)
    node = @root

    while node
      break if value == node.data

      location = proc { |set| value < node.data ? "left#{set}" : "right#{set}" }

      if node.send(location.call).nil?
        node.send(location.call('='), Node.new(value))
      else
        node = node.send(location.call)
      end
    end
  end

  # Deletes a leaf Node from the Tree
  def delete(value)
    node = @root

    while node
      location = proc { |set| value < node.data ? "left#{set}" : "right#{set}" }

      break if node.send(location.call).nil?

      node.send(location.call('='), nil) if value == node.send(location.call).data
      node = node.send(location.call)
    end
  end

  # Pretty prints the Tree
  def print(node = @root, prefix = '', is_left = true)
    print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
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
