class Tree
  attr_reader :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

  def build_tree(array, start = 0, ending = nil)
    ending = array.length - 1 if ending.nil?

    if start > ending
      nil
    else
      mid = (start + ending) / 2

      left_child = build_tree(array, start, mid - 1)
      right_child = build_tree(array, mid + 1, ending)

      root = Node.new(array[mid], left_child, right_child)
    end
    root
  end

  def insert(value, node = root)
    if value == node.data
      puts "Value is already in the tree. Insertion will not be executed."
    elsif value < node.data
      if node.left_child.nil?
        node.left_child = Node.new(value, nil, nil)
        return
      end
      node = node.left_child
      insert(value, node)
    elsif value > node.data
      if node.right_child.nil?
        node.right_child = Node.new(value, nil, nil)
        return
      end
      node = node.right_child
      insert(value, node)
    end
  end

  # The pretty print method is derived from the assignment instructions

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child

    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"

    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
