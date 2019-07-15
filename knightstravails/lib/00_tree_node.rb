class PolyTreeNode

    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        @parent.children.delete(self) if self.parent
        @parent = node
        node.children << self if node != nil
    end

    def add_child(child_node)
        child_node.parent=self
    end

    def remove_child(child_node)
        raise "node is not a child" if !child_node.parent
        child_node.parent=nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        unless self.children == []
            children.each do |child|
                result = child.dfs(target_value)
                return result if result
            end
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            current_node = queue.pop
            return current_node if current_node.value == target_value
            current_node.children.each { |child| queue.unshift(child)}
        end
        nil
    end

    def print_tree
        queue = [self]
        until queue.empty?
            current_node = queue.pop
            if current_node == ""
                puts current_node
                next
            end
            p current_node.value
            current_node.children.each { |child| queue.unshift(child)}
            queue.unshift("")
        end

    end

    def inspect
       p @value
    end

    def trace_path_back
        return [] if parent.nil?

        [self.value] + parent.trace_path_back
    end

end