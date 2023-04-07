# frozen_string_literal: true

# Linked List
class LinkedList
  attr_reader :head, :tail, :size
  private attr_writer :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    @size += 1

    if @head.nil?
      @head = Node.new(value)
      @tail = @head
    else
      @tail.next_node = Node.new(value)
      @tail = @tail.next_node
    end
  end

  def prepend(value)
    @size += 1

    if @head.nil?
      @head = Node.new(value)
      @tail = @head
    else
      @head = Node.new(value, @head)
    end
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
