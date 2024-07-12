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

      node = Node.new(array[mid])

      node.left_child = build_tree(array, start, mid - 1)
      node.right_child = build_tree(array, mid + 1, ending)
    end
    node
  end

  def height(value)
    node = find(value)
    height_recursive(node) - 1
  end

  def height_recursive(node)
    return 0 if node.nil?
    left_height = height_recursive(node.left_child)
    right_height = height_recursive(node.right_child)
    [left_height, right_height].max + 1
  end

  def preorder(node = root, values = [], &block)
    return if node.nil?

    block_given? ? yield(node) : values.push(node.data)
    preorder(node.left_child, values, &block)
    preorder(node.right_child, values, &block)

    values
  end

  def inorder(node = root, values = [], &block)
    return if node.nil?

    inorder(node.left_child, values, &block)
    block_given? ? yield(node) : values.push(node.data)
    inorder(node.right_child, values, &block)

    values
  end

  def postorder(node = root, values = [], &block)
    return if node.nil?

    postorder(node.left_child, values, &block)
    postorder(node.right_child, values, &block)
    block_given? ? yield(node) : values.push(node.data)

    values
  end

  def level_order_iterative(node = root)
    return if node.nil?
    queue = [node]
    values = []

    until queue.empty?
      block_given? ? yield(queue[0]) : values.push(queue[0].data)

      queue.push(node.left_child) unless node.left_child.nil?

      queue.push(node.right_child) unless node.right_child.nil?

      queue.shift
      node = queue[0]
    end
    values unless block_given?
  end

  def level_order_recursive(node = root, queue = [node], values = [], &block)
    return if node.nil? || queue.empty?

    block_given? ? yield(queue[0]) : values.push(queue[0].data)

    queue.push(node.left_child) unless node.left_child.nil?

    queue.push(node.right_child) unless node.right_child.nil?

    queue.shift

    level_order_recursive(queue[0], queue, values, &block)

    values unless block_given?
  end

  def delete(value, node = root)
    if node.nil?
      return node
    elsif value < node.data
      node.left_child = delete(value, node.left_child)
    elsif value > node.data
      node.right_child = delete(value, node.right_child)
    else # if value is same as the node's data
      # node with only 1 or 0 children
      if node.left_child.nil?
        return node.right_child
      elsif node.right_child.nil?
        return node.left_child
      end

      # node with 2 children
      node.data = inorder_successor(node.right_child).data

      node.right_child = delete(node.data, node.right_child)
    end

    node
  end

  def inorder_successor(inorder_successor)
    unless inorder_successor.left_child.nil?
      inorder_successor = inorder_successor.left_child until inorder_successor.left_child.nil?
    end
    inorder_successor
  end

  def insert(value, node = root)
    if node.nil?
      return Node.new(value)
    elsif value == node.data
      puts "Value is already in the tree. Insertion will not be executed."
    elsif value < node.data
      node.left_child = insert(value, node.left_child)
    elsif value > node.data
      node.right_child = insert(value, node.right_child)
    end

    node
  end

  def find(value, node = root)
    if node.nil?
      puts "Value does not exist in the tree."
      nil
    elsif value == node.data
      node
    elsif value < node.data
      find(value, node.left_child)
    elsif value > node.data
      find(value, node.right_child)
    end
  end

  # The pretty print method is derived from the assignment instructions

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child

    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"

    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
