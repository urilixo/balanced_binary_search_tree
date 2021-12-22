require_relative 'Tree'
require_relative 'Node'

test = Tree.new(Array.new(15) { rand(1..100) })
test.balanced? # => true
# TODO: Print out all elements in level, pre, post, and in order
# TODO: Add random numbers > 100
test.balanced? # => false
test.rebalance
test.balanced? # => true
# TODO: Print out all elements in level, pre, post, and in order


