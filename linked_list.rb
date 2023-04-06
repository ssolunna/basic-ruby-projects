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
end

# Node
class Node
  attr_accessor :next_node

  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end
