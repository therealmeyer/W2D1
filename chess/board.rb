require_relative 'piece'
#phase 2 after NB 
class Board
  def initialize
  @grid = create_grid
  end

  def create_grid
    grid = Array.new(8) { Array.new(8) }
    grid.each_with_index do |row, idx|
      if [0,1,6,7].include?(idx)
        grid[idx].map! { |space| space = Piece.new}
      else
        grid[idx].map! { |space| space = NullPiece.instance}
      end
    end
    grid
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def move_piece(start_pos, end_pos)
    raise "No piece at #{start_pos}" if self[start_pos].class == NullPiece
    raise "Not valid move" unless valid_move?(end_pos)

    piece_obj = self[start_pos]
    self[start_pos] = NullPiece.instance
    self[end_pos] = piece_obj
    p @grid
    #change piece_obj position
  end


  def valid_move?(pos)
    return false unless (0...8).include?(pos.first)
    return false unless (0...8).include?(pos.last)
    true
  end



end


b = Board.new
b.move_piece([0,0],[2,0])
