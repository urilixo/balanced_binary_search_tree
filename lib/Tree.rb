require 'pry-byebug'
class Tree
  require_relative 'Node'
  attr_accessor :root

  def initialize(array)
    array.uniq!.sort!
    @root = build_tree(array)
  end

  def build_tree(array)
    return if array.empty?

    return Node.new(array[0], nil, nil) if array.length == 1

    root = array.length / 2
    left = build_tree(array[0..root - 1])
    right = build_tree(array[root + 1..-1])
    Node.new(array[root], left, right)
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

  def level_order(node: @root)
    queue = [node]
    data = []

    until queue.empty?
      current_node = queue.pop
      queue.unshift(current_node.left_children) unless current_node.left_children.nil?
      queue.unshift(current_node.right_children) unless current_node.right_children.nil?

      if block_given?
        yield(current_node)
      else
        data << current_node.value
      end
    end
    data unless block_given?
  end

  def inorder(node: @root, array: [])
    return unless node

    inorder(node: node.left_children, array: array)
    array << node unless block_given?
    inorder(node: node.right_children, array: array)
    return array.map(&:value) unless block_given?

    array.each { |value| yield(value)} if block_given?
  end

  def preorder
  end

  def postorder
  end

  # returns the distance from node to leaf
  def height(node)
    height_sum = 0
    return height_sum if node.left_children.nil? && node.right_children.nil?

    height_sum += 1
    return height_sum += height(node.left_children) unless node.left_children.nil?
    return height_sum += height(node.right_children) unless node.right_children.nil?

    height_sum
  end

  # returns the distance from node to root
  def depth(node)
    height(@root) - height(node)
  end

  def rebalance
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right_children, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right_children
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_children, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left_children
  end
end

a = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
p a.root
p a.pretty_print
#p a.find(7)
#b = a.find(7)
#p a.depth(b)
#p a.level_order
#p a.level_order {|node| puts node.value}
p a.inorder
(a.inorder {|node| puts node.value})
