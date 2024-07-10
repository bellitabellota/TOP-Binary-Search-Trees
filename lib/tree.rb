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

  def delete(value)
    node_with_value = find(value)
    return puts "Deletion cannot be executed." if node_with_value.nil?

    if node_with_value.left_child.nil? && node_with_value.right_child.nil?
      delete_leaf(node_with_value)
    elsif node_with_value.left_child.nil? || node_with_value.right_child.nil?
      delete_node_with_one_child(node_with_value)
    else
      delete_node_with_two_childs(node_with_value)
    end
  end

  def delete_node_with_two_childs(node_with_value)
    parent_of_inorder_successor = find_parent_of_inorder_successor(node_with_value)
    puts "Parent of inorder successor"
    p parent_of_inorder_successor

    if node_with_value.right_child.left_child.nil?
      node_with_value.data = parent_of_inorder_successor.right_child.data
      node_with_value.right_child = parent_of_inorder_successor.right_child.right_child
    else
      node_with_value.data = parent_of_inorder_successor.left_child.data
      if parent_of_inorder_successor.left_child.right_child.nil?
        parent_of_inorder_successor.left_child.data = nil
      else
        parent_of_inorder_successor.left_child = parent_of_inorder_successor.left_child.right_child
      end
    end
  end

  def find_parent_of_inorder_successor(node_with_value)
    if node_with_value.right_child.left_child.nil?
      parent_of_inorder_successor = node_with_value
    else
      parent_of_inorder_successor = node_with_value.right_child

      until parent_of_inorder_successor.left_child.left_child.nil?
        parent_of_inorder_successor = inorder_successor.left_child
      end
    end
    parent_of_inorder_successor
  end

  def delete_node_with_one_child(node_with_value, node = root)
    if node.left_child == node_with_value
      if node.left_child.left_child
        node.left_child = node.left_child.left_child
      elsif node.left_child.right_child
        node.left_child = node.left_child.right_child
      end
      return
    elsif node.right_child == node_with_value
      if node.right_child.right_child
        node.right_child = node.right_child.right_child
      elsif node.right_child.left_child
        node.right_child = node.right_child.left_child
      end
      return
    elsif node_with_value.data < node.data
      node = node.left_child
    elsif node_with_value.data > node.data
      node = node.right_child
    end
    delete_node_with_one_child(node_with_value, node)
  end

  def delete_leaf(node_with_value, node = root)
    if node.left_child == node_with_value
      node.left_child = nil
      return
    elsif node.right_child == node_with_value
      node.right_child = nil
      return
    elsif node_with_value.data < node.data
      node = node.left_child
    elsif node_with_value.data > node.data
      node = node.right_child
    end
    delete_leaf(node_with_value, node)
  end

  def insert(value, node = root)
    if value == node.data
      puts "Value is already in the tree. Insertion will not be executed."
    elsif value < node.data
      if node.left_child.nil?
        node.left_child = Node.new(value)
        return
      end
      node = node.left_child
      insert(value, node)
    elsif value > node.data
      if node.right_child.nil?
        node.right_child = Node.new(value)
        return
      end
      node = node.right_child
      insert(value, node)
    end
  end

  def find(value, node = root)
    if value == node.data
      node
    elsif value < node.data
      return puts "Value does not exist in the tree." if node.left_child.nil?

      node = node.left_child

      node.data == value ? node : find(value, node)
    elsif value > node.data
      return puts "Value does not exist in the tree." if node.right_child.nil?

      node = node.right_child

      node.data == value ? node : find(value, node)
    end
  end

  # The pretty print method is derived from the assignment instructions

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child

    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"

    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
