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

  protected

  def remove(node)
    if left == node
      self.left = nil
    else
      self.right = nil
    end

    node
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
    @root.nil? ? @root = Node.new(value) : node = @root

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

  # Deletes a Node from the Tree
  def delete(value)
    node = @root
    parent_node = nil

    while node
      if value == node.data
        if leaf?(node)
          node == @root ? @root = nil : parent_node.remove(node)
        else # has only one child
          child = node.left || node.right
          node == @root ? @root = nil : parent_node.remove(node)
          insert(child.data)
        end

        break
      end

      parent_node = node
      node = value < node.data ? node.left : node.right
    end
  end

  def leaf?(node)
    return true unless node.left || node.right

    false
  end

  # Pretty prints the Tree
  def print(node = @root, prefix = '', is_left = true)
    return if @root.nil?

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
