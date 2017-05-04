require_relative "simulator"

module ToyRobotSimulator
  class Command
    PLACE_MATCHER = /^PLACE ([0-4]),([0-4]),(NORTH|SOUTH|EAST|WEST)$/

    @@comand = nil
    @@simulator = nil

    def self.command(command)
      @@command = command
      execute
    end

    private

    def self.execute
      if @@command == "PLACE"
        @@simulator = ToyRobotSimulator::Simulator.new
        @@simulator.place(0, 0, "NORTH")
      elsif inputs = @@command.match(PLACE_MATCHER)
        x, y, facing = inputs[1], inputs[2], inputs[3]
        @@simulator = ToyRobotSimulator::Simulator.new
        @@simulator.place(x, y, facing)
      elsif @@command == "MOVE"
        @@simulator.move
      elsif @@command == "LEFT"
        @@simulator.left
      elsif @@command == "RIGHT"
        @@simulator.right
      elsif @@command == "REPORT"
        @@simulator.report
      elsif @@command == "HELP"
        puts "Available commands:"
        puts "PLACE X,Y,F (X and Y can be 0-4 and F can be NORTH, SOUTH, EAST, WEST"
        puts "MOVE (move robot one unit forward in the direction it is currently facing)"
        puts "LEFT or RIGHT (will rotate the robot 90 degrees in the specified direction without changing the position of the robot)"
        puts "REPORT (will announce the X,Y and F of the robot)"
        puts "EXIT (exit the simulator)"
      else
        puts "You type an invalid command. Please use available commands by typing in HELP"
      end
    rescue => e
      puts "Something went wrong. Check the errors:"
      puts e.message
    end
  end
end
