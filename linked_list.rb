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

  def each
    return to_enum(:each) unless block_given?

    node = @head

    @size.times do
      yield node
      node = node.next_node
    end

    self
  end

  def each_with_index
    index = 0

    each do |node|
      yield node, index
      index += 1
    end

    self
  end

  def at(index)
    index = @size + index if index.negative?

    case index
    when 0 then @head
    when @size - 1 then @tail
    when 1...@size
      each_with_index { |node, i| return node if i == index }
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
