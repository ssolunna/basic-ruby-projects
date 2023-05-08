# frozen_string_literal: true

# Nodes of the Tree
class Node
  attr_reader :data, :left, :right
  protected attr_writer :data, :left, :right

  def initialize(tree, data, left = nil, right = nil)
    @tree = tree
    @data = data
    @left = left
    @right = right
  end

  protected

  def remove(node)
    if self == node
      @tree.remove_root
    elsif left == node
      @left = nil
    else
      @right = nil
    end

    node
  end

  def add(node)
    node.data < data ? @left = node : @right = node
  end
end

# Binary Search Tree
class Tree < Node
  attr_reader :array, :root

  def initialize(array)
    @array = array
    @root = build_tree(array.uniq.sort)
  end

  # Returns the Node with the given value
  def find(value)
    node = @root

    while node
      break if value == node.data

      node = value < node.data ? node.left : node.right
    end

    node
  end

  # Traverses the Tree in breadth-first level order
  def level_order(queue = [@root])
    return @array unless block_given?

    until queue.empty?
      node = queue.first
      yield node
      queue.shift
      queue.append node.left, node.right
      queue.compact!
    end
  end

  # Traverses the Tree in breadth-first level order using recursion
  def rlevel_order(queue = [@root], &block)
    return @array unless block_given?

    return if queue.empty?

    node = queue.first
    yield node
    queue.shift
    queue.append node.left, node.right

    rlevel_order(queue.compact, &block)
  end

  # Traverses the Three in deep-first inorder
  def inorder(node = @root, &block)
    return @array unless block_given?

    return if node.nil?

    inorder(node.left, &block)
    yield node
    inorder(node.right, &block)
  end

  # Traverses the Tree in deep-first preorder
  def preorder(node = @root, &block)
    return @array unless block_given?

    return if node.nil?

    yield node
    preorder(node.left, &block)
    preorder(node.right, &block)
  end

  # Traverses the Tree in deep-first postorder
  def postorder(node = @root, &block)
    return @array unless block_given?

    return if node.nil?

    postorder(node.left, &block)
    postorder(node.right, &block)
    yield node
  end

  # Finds the height of a given node
  def height(value)
    node = find(value)

    return unless node

    right_child = node.right
    left_child = node.left

    right_children = 0
    while right_child
      right_children += 1
      right_child = right_child.right
    end

    left_children = 0
    while left_child
      left_children += 1
      left_child = left_child.left
    end

    right_children > left_children ? right_children : left_children
  end

  # Finds the depth of a given node
  def depth(value)
    return unless find(value)
    return 0 if value == @root.data

    node = @root
    size = 0

    while node
      size += 1

      return size if value == node.left.data || value == node.right.data

      node = value < node.data ? node.left : node.right
    end
  end

  # Inserts a leaf Node in the Tree
  def insert(value)
    @root.nil? ? @root = Node.new(self, value) : node = @root

    while node
      break if value == node.data

      location = proc { |set| value < node.data ? "left#{set}" : "right#{set}" }

      if node.send(location.call).nil?
        node.send(location.call('='), Node.new(self, value))
      else
        node = node.send(location.call)
      end
    end
  end

  # Deletes a Node from the Tree
  def delete(value)
    node = @root

    while node
      if value == node.data
        parent_node = @root if node == @root

        if leaf?(node)
          parent_node.remove(node)
        elsif two_children?(node)
          node.data = delete_inorder_successor(node).data
        else # has only one child
          child = node.left || node.right
          parent_node.remove(node)
          parent_node.add(child)
        end

        return node
      end

      parent_node = node
      node = value < node.data ? node.left : node.right
    end
  end

  def delete_inorder_successor(node)
    successor = node.right

    successor = successor.left while successor.left

    delete(successor.data)

    successor
  end

  def leaf?(node)
    return true unless node.left || node.right

    false
  end

  def two_children?(node)
    node.left && node.right
  end

  # Pretty prints the Tree
  def print(node = @root, prefix = '', is_left = true)
    return if @root.nil?

    print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def remove_root
    @root = nil
  end
end

# Turns a sorted array (without duplicate elements)
# into a balanced binary tree
def build_tree(array)
  return if array.empty?

  mid = (0 + array.size - 1) / 2
  left = build_tree(array[0...mid])
  right = build_tree(array[mid + 1...array.size])

  Node.new(self, array[mid], left, right)
end
