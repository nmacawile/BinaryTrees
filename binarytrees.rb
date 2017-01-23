class Array
	# Divides an array into two parts.
	# If the number of elements is an odd number, 
	# the second array will have the extra element,
	# otherwise, they are equal in size.
	def halve
		return [[], self] if self.size == 1
		return [[], []] if self.empty?
		half = self.size / 2
		[self[0...half], self[half..-1]]
	end

	def build_tree
		Node.tree(self.sort)
	end

end

class Node
	attr_accessor :value, :child_a, :child_b
	
	def initialize(value)
		@value = value
	end
	
	def self.build_tree(array)
		self.tree(array.sort)
	end
	
	def self.tree(array)
		return if array.empty?
		a, b = array.halve
		
		node = self.new(b.shift)
		node.child_a, node.child_b = self.tree(a), self.tree(b)
		node
	end
	
	def breadth_first_search
		array = []
		queue = [self]
		loop do
			break if queue.empty?
			node = queue.shift
			array << node.value
			queue << node.child_a unless node.child_a.nil?
			queue << node.child_b unless node.child_b.nil?
		end
		array
	end

	def depth_first_search
		array = []
		stack = [self]
		loop do
			break if stack.empty?
			node = stack.pop
			array << node.value
			stack << node.child_b unless node.child_b.nil?
			stack << node.child_a unless node.child_a.nil?			
		end
		array
	end

	def depth_first_search_rec
		self.class.dfs_rec(self)
	end
	
	def self.dfs_rec(tree, arr = [])		# dfs pre-order (root, left, right)
		return arr if tree.nil?
		arr << tree.value					#root
		self.dfs_rec(tree.child_a, arr)		#left
		self.dfs_rec(tree.child_b, arr)		#right
		arr
	end
end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree = array.build_tree

puts "Input array: #{array.inspect}"
puts "Sorted array: #{array.sort.inspect}"

puts "Depth-First Search: #{tree.depth_first_search.inspect}"
puts "Depth-First Search (recursive): #{tree.depth_first_search_rec.inspect}"
puts "Breadth-First Search: #{tree.breadth_first_search}"
