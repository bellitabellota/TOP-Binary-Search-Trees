class Node
  attr_accessor :left_child, :right_child, :node

  def initialize(node, left_child, right_child)
    @node = node
    @left_child = left_child
    @right_child = right_child
  end
end
