module RubyWarrior
  class Walk < Ability
    DIRECTIONS = {
      :forward => [1, 0],
      :right   => [0, 1],
      :back    => [-1, 0],
      :left    => [0, -1]
    }
    
    def initialize(direction)
      @offset = DIRECTIONS[direction]
    end
    
    def act
      owner.position.move(*@offset)
    end
  end
end
