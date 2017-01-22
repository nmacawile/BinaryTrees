
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
		stack = [[self]]
		loop do
			temp = []
			p stack.last
			stack.last.each do |node|
				array << node.value	unless node.nil?
				temp << node.child_a unless node.nil? || node.child_a.nil?	
				temp << node.child_b unless node.nil? || node.child_b.nil?
			end

			break if temp.empty?
			stack << temp
		end

		array
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
#puts "Input array: #{array.inspect}"
tree = array.build_tree

#puts "Depth-First Search: #{Node.dfs_rec(tree).inspect}"
puts "Breadth-First Search: #{tree.breadth_first_search}"
