# frozen_string_literal: true

# Linked List
class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  def append(value)
    if @head.nil?
      @head = Node.new(value)
    else
      node = @head
      node = node.next_node until node.next_node.nil?
      node.next_node = Node.new(value)
    end
  end

  def prepend(value)
    @head = @head.nil? ? Node.new(value) : Node.new(value, @head)
  end
end

# Node
class Node
  attr_accessor :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end
