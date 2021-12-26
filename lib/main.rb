require_relative 'Tree'
require_relative 'Node'

test = Tree.new(Array.new(15) { rand(1..100) })
test.balanced? # => true
p test.preorder
p test.postorder
p test.inorder
p test.pretty_print
20.times {test.insert(rand(101..200)) }
p test.pretty_print

# TODO: Print out all elements in level, pre, post, and in order
# TODO: Add random numbers > 100
p test.balanced? # => false
test.rebalance
p test.pretty_print
p test.balanced? # => true
# TODO: Print out all elements in level, pre, post, and in order


