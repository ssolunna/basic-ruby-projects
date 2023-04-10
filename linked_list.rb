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

  # Adds a new node containing (value) to the end of the list
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

  # Adds a new node containing (value) to the start of the list
  def prepend(value)
    @size += 1

    if @head.nil?
      @head = Node.new(value)
      @tail = @head
    else
      @head = Node.new(value, @head)
    end
  end

  # Iterates over the linked list nodes passing each node to the block
  def each
    return to_enum(:each) unless block_given?

    node = @head

    @size.times do
      yield node
      node = node.next_node
    end

    self
  end

  # Iterates over the linked list nodes passing the node
  # and its position in the list to the block
  def each_with_index
    index = 0

    each do |node|
      yield node, index
      index += 1
    end

    self
  end

  # Returns the node at the given index
  def at(index)
    index = @size + index if index.negative?

    case index
    when 0 then @head
    when @size - 1 then @tail
    when 1...@size
      each_with_index { |node, i| return node if i == index }
    end
  end

  # Removes the last node from the list
  def pop
    return if @size.zero?

    if @size == 1
      @head, @tail = nil
    else
      previous_node = at(-2)
      previous_node.next_node = nil
      @tail = previous_node
    end

    @size -= 1
  end

  # Returns true if the passed in value is in the list
  # Otherwise returns false
  def contains?(value)
    each { |node| return true if node.value == value }

    false
  end

  # Returns the index of the node containing the passed in value
  # Otherwise returns nil
  def find(value)
    each_with_index { |node, index| return index if node.value == value }

    nil
  end

  # Represents the linked list objects as string and prints it
  def to_s
    return if @size.zero?

    each { |node| print "( #{node.value} ) -> " }
    puts 'nil'
  end
end

# Node
class Node
  attr_accessor :next_node, :value

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end
