require_relative "lib/node"
require_relative "lib/tree"

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

tree.pretty_print

#p tree.root.node
#p tree.root.left_child.node

 #tree.insert(0)