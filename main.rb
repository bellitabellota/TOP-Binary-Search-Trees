require_relative "lib/node"
require_relative "lib/tree"

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print

p tree.balanced?

p tree.level_order_iterative
p tree.level_order_recursive

p tree.preorder
p tree.inorder
p tree.postorder

5.times do
  tree.insert(rand(100..200))
end

tree.pretty_print
p tree.balanced?

tree.rebalance
tree.pretty_print
p tree.balanced?

p tree.level_order_iterative
p tree.level_order_recursive

p tree.preorder
p tree.inorder
p tree.postorder
