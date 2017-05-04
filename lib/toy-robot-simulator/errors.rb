module ToyRobotSimulator
  class InvalidPositionError < StandardError
    def initialize(msg='Invalid position values')
      super
    end
  end

  class InvalidFacingError < StandardError
    def initialize(msg='Invalid facing, valid facing are: :north, :south, :east, :west')
      super
    end
  end

  class InvalidCommandError < StandardError
    def initialize(msg='Invalid command, maybe you should try to place the robot first.')
      super
    end
  end
end
