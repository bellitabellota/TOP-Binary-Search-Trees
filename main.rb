require_relative "lib/node"
require_relative "lib/tree"

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
 tree.pretty_print

# p tree.root.data
# p tree.root.left_child.data

# tree.insert(70)
# tree.pretty_print

# deleting_leaf_node(3)

# tree.level_order_iterative
# tree.level_order_recursive { |node| p node.data }

#tree.preorder { |node| puts node.data }

# tree.inorder
# tree.postorder { |node| puts node.data }

# p tree.height(4)

# p tree.depth(23)

#p tree.balanced?





tree.pretty_print

p tree.balanced?

