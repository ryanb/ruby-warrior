module RubyWarrior
  class Floor
    attr_accessor :width, :height, :grid
    
    def initialize(width, height)
      @width = width
      @height = height
      @grid = Array.new(width) { Array.new(height) }
    end
    
    def get(row, col)
      @grid[row][col]
    end
    
    def set(obj, row, col)
      @grid[row][col] = obj
    end
    
    def clear(row, col)
      obj = get(row, col)
      @grid[row][col] = nil
      obj
    end
    
    # TODO make sure the objects returned are in a consistant order
    def objects
      @grid.flatten.compact
    end
  end
end
