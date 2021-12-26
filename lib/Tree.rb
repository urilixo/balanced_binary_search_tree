
class Tree
  require_relative 'Node'
  attr_accessor :root

  def initialize(array)
    p array
    array.uniq.sort!
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

  # Insertion happens at the first found leaf
  def insert(value)
    node = @root
    until node.left_children.nil? && node.right_children.nil?
      next node = node.left_children if value < node.value && !node.left_children.nil?
      next node = node.right_children if value > node.value && !node.right_children.nil?

      break
    end
    value < node.value ? node.left_children = build_tree([value]) : node.right_children = build_tree([value])
  end

  def delete(value, node: @root)
    return node if node.nil?

    if value < node.value
      node.left_children = delete(value, node: node.left_children)
    elsif value > node.value
      node.right_children = delete(value, node: node.right_children)
    else
      return node.right_children if node.left_children.nil?
      return node.left_children if node.right_children.nil?

      node.value = inorder(node: node.right_children)[0]
      node.right_children = delete(node.value, node: node.right_children)
    end
    node
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
    array << node
    inorder(node: node.right_children, array: array)
    return array.map(&:value) unless block_given?

    array.each { |value| yield(value)} if block_given?
  end

  def preorder(node: @root, array: [])
    return unless node

    array << node
    preorder(node: node.left_children, array: array)
    preorder(node: node.right_children, array: array)

    return array.map(&:value) unless block_given?

    array.each { |value| yield(value)} if block_given?
  end

  def postorder(node: @root, array: [])
    return unless node

    postorder(node: node.left_children, array: array)
    postorder(node: node.right_children, array: array)

    array << node
    return array.map(&:value) unless block_given?

    array.each { |value| yield(value)} if block_given?
  end

  # returns the distance from node to leaf
  def height(node)
    height_sum = 0
    return 0 if node.nil?
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

  def balanced?(node: @root)
    return true if node.nil?

    left_height = height(node.left_children)
    right_height = height(node.right_children)
    (left_height - right_height).abs <= 1 && balanced?(node: node.left_children) && balanced?(node: node.right_children)
  end

  def rebalance
    @root = build_tree(postorder)
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right_children, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right_children
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_children, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left_children
  end
end
