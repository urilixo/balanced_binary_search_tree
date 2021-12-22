require 'pry-byebug'
class Tree
  require_relative 'Node'
  attr_accessor :root

  def initialize(array)
    array.uniq!.sort!
    build_tree(array)
  end

  def build_tree(array)
    return if array.empty?

    return Node.new(array[0], nil, nil) if array.length == 1

    root = array.length / 2
    left = build_tree(array[0..root-1])
    right = build_tree(array[root+1..-1])
    @root = Node.new(array[root], left, right)
  end

  def insert
  end

  def delete
  end

  def find(value, node: @root)
    return node if node.value == value
    return if node.value.nil?

    if value > node.value
      return find(value, node: node.right_children) unless node.right_children.nil?
    else
      return find(value, node: node.left_children) unless node.left_children.nil?
    end
  end

  def level_order
  end

  def inorder
  end

  def preorder
  end

  def postorder
  end
  
  def height
  end
  
  def depth
  end

  def rebalance
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_children, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_children
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_children, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_children
  end
end

a = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
p a.root
p a.pretty_print
p a.find(7)
