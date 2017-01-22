
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
		
		
	end
	
	def self.bfs
		
	end
		
end


array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]


node= Node.build_tree(array)