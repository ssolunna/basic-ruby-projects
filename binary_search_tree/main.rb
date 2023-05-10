# frozen_string_literal: true

require_relative 'binary_search_tree.rb'

puts 'Create a binary search tree from an array of random numbers:'
array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)
p array
tree.print
puts

print 'Balanced tree?: '
puts tree.balanced?
puts

puts 'Print out all elements in level order: '
array = []
tree.level_order { |node| array << node.data } 
p array
puts

puts 'Print out all elements in preorder: '
array = []
tree.preorder { |node| array << node.data } 
p array
puts

puts 'Print out all elements in postorder: '
array = []
tree.postorder { |node| array << node.data } 
p array
puts

puts 'Print out all elements in order: '
array = []
tree.inorder { |node| array << node.data } 
p array
puts

puts 'Unbalance the tree by adding several numbers > 100:'
15.times { tree.insert(rand(100..200)) }
tree.print
puts

print 'Unbalanced tree?: '
puts !tree.balanced?
puts

puts 'Balance the tree:'
tree.rebalance
tree.print
puts

print 'Balanced tree?: '
puts tree.balanced?
puts

puts 'Print out all elements in level order: '
array = []
tree.level_order { |node| array << node.data } 
p array
puts

puts 'Print out all elements in preorder: '
array = []
tree.preorder { |node| array << node.data } 
p array
puts

puts 'Print out all elements in postorder: '
array = []
tree.postorder { |node| array << node.data } 
p array
puts

puts 'Print out all elements in order: '
array = []
tree.inorder { |node| array << node.data } 
p array
