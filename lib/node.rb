class Node
  attr_accessor :left_child, :right_child, :data

  def initialize(data, left_child, right_child)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end
