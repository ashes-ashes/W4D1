require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_accessor :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      if @board.winner == evaluator || @board.winner == nil
        return false
      else
        return true
      end
    end
    if @next_mover_mark == evaluator
      self.children.all? { |child| child.losing_node?(evaluator) }
    else
      self.children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      if @board.winner == evaluator
        return true
      else
        return false
      end
    end
    if next_mover_mark == evaluator
      self.children.any? { |child| child.winning_node?(evaluator) }
    else
      self.children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves = []
    @board.rows.each_with_index do |row, idx1|
      row.each_with_index do |pos, idx2|
        if pos.nil?
          newboard = []
          @board.rows.each { |sub| newboard << sub.dup }
          newboard[idx1][idx2] = @next_mover_mark
          newmark = nil
          @next_mover_mark == :x ? newmark = :o : newmark = :x
          moves << TicTacToeNode.new(Board.new(newboard), newmark, [idx1, idx2])
        end
      end
    end
    moves
  end


end
