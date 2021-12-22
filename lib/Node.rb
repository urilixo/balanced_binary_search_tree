class Node
  attr_accessor :value, :left_children, :right_children

  def initialize(value, left_children, right_children)
    self.value = value
    self.left_children = left_children
    self.right_children = right_children
  end
end