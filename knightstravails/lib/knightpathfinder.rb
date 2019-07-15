require_relative "00_tree_node"

class KnightPathFinder

    attr_reader :root_node

    def initialize(coordinates)
        @root_node = PolyTreeNode.new(coordinates)
        @considered_positions = []
        build_move_tree
    end

    def self.valid_moves(pos)
        directions = [[-2, -1],[-2, 1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
        possible_moves = []
        directions.each do |direction|
            move = [direction[0]+pos[0],direction[1]+pos[1]]
            if move.all? { |coord| coord >= 0 && coord <= 8}
                possible_moves << move
            end
        end
        possible_moves
    end

    def new_move_positions(pos)
        newpos = KnightPathFinder.valid_moves(pos)
        newpos -= @considered_positions
        @considered_positions += newpos
        newpos
    end

    def build_move_tree
        start_pos = @root_node
        squeue = [start_pos]
        until squeue.empty?
            current_pos = squeue.pop
            moves = self.new_move_positions(current_pos.value)
            moves.each do |move|
                newpos = PolyTreeNode.new(move)
                newpos.parent = current_pos
                squeue.unshift(newpos)
            end
        end
    end

    def find_path(end_pos)
        root_node.bfs(end_pos).trace_path_back
    end


end

if __FILE__ == $PROGRAM_NAME
    kpf = KnightPathFinder.new([0,0])
    p KnightPathFinder.valid_moves([0,0])
    p kpf.find_path([5, 6])
    #kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
    #kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]
end
