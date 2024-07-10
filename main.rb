require_relative "lib/node"
require_relative "lib/tree"

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
 tree.pretty_print

# p tree.root.data
# p tree.root.left_child.data

# tree.insert(70)
tree.pretty_print

# deleting_leaf_node(3)

# tree.find(6)

p tree.root

tree.delete(4)

tree.pretty_print
#p tree.root

