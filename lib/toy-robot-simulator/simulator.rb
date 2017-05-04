require_relative 'errors'
require_relative 'execution_hooks'

module ToyRobotSimulator
  class Simulator
    extend ExecutionHooks

    MAX_X = 4
    MAX_Y = 4
    VALID_FACINGS = ["NORTH", "SOUTH", "EAST", "WEST"]

    attr_reader :current_facing, :current_position

    before_invoke :check_if_first_command, only: [:move, :left, :right, :report]

    def initialize
      @first_move = true
      @current_position = { x: 0, y: 0 }
    end

    def place(x,y,facing)
      set_facing(facing)
      set_position(x,y)
      set_first_move! if @first_move
    end

    def move
      case @current_facing
      when "NORTH"
        y = @current_position[:y] + 1
        set_position(@current_position[:x], y)
      when "SOUTH"
        y = @current_position[:y] - 1
        set_position(@current_position[:x], y)
      when "EAST"
        x = @current_position[:x] + 1
        set_position(x, @current_position[:y])
      when "WEST"
        x = @current_position[:x] - 1
        set_position(x, @current_position[:y])
      end
    end

    def left
      case @current_facing
      when "NORTH"
        set_facing("WEST")
      when "SOUTH"
        set_facing("EAST")
      when "EAST"
        set_facing("NORTH")
      when "WEST"
        set_facing("SOUTH")
      end
      report_current_position
    end

    def right
      case @current_facing
      when "NORTH"
        set_facing("EAST")
      when "SOUTH"
        set_facing("WEST")
      when "EAST"
        set_facing("SOUTH")
      when "WEST"
        set_facing("NORTH")
      end
      report_current_position
    end

    def report
      position = @current_position.values.join(",")
      "# Output: #{position},#{@current_facing.to_s.upcase}"
    end

    private

    def check_if_first_command
      fail InvalidCommandError if @first_move
    end

    def set_first_move!
      @first_move = false
      ""
    end

    def set_facing(facing)
      if ToyRobotSimulator::Simulator::VALID_FACINGS.include?(facing)
        @current_facing = facing
      else
        fail ToyRobotSimulator::InvalidFacingError
      end
    end

    def set_position(x,y)
      x = x.to_i
      y = y.to_i

      if valid_position?(x,y)
        @current_position[:x], @current_position[:y] = x, y
        report_current_position
      else
        fail ToyRobotSimulator::InvalidPositionError
      end
    end

    def report_current_position
      puts "# Current position: #{@current_position[:x]},#{@current_position[:y]},#{@current_facing}"
    end

    def valid_position?(x,y)
      x.between?(0, MAX_X) && y.between?(0, MAX_Y)
    end
  end
end
