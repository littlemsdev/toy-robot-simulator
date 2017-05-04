require 'rspec'
require 'toy-robot-simulator/simulator'

RSpec.describe 'Simulate Robot' do
  describe 'Example A' do
    it 'should print correct output' do
      simulator = ToyRobotSimulator::Simulator.new
      simulator.place(0,0, "NORTH")
      simulator.move
      expect(simulator.report).to eq '# Output: 0,1,NORTH'
    end
  end

  describe 'Example B' do
    it 'should print correct output' do
      simulator = ToyRobotSimulator::Simulator.new
      simulator.place(0,0, "NORTH")
      simulator.left
      expect(simulator.report).to eq '# Output: 0,0,WEST'
    end
  end

  describe 'Example C' do
    it 'should print correct output' do
      simulator = ToyRobotSimulator::Simulator.new
      simulator.place(1,2, "EAST")
      simulator.move
      simulator.move
      simulator.left
      simulator.move
      expect(simulator.report).to eq '# Output: 3,3,NORTH'
    end
  end

  describe 'Errors' do
    it 'out of the table when placed' do
      simulator = ToyRobotSimulator::Simulator.new
      expect{ simulator.place(6,0, "NORTH") }.to raise_error ToyRobotSimulator::InvalidPositionError
    end

    it 'invoke invalid command on first command' do
      simulator = ToyRobotSimulator::Simulator.new
      expect{ simulator.move }.to raise_error ToyRobotSimulator::InvalidCommandError
    end

    it 'when input invalid facing' do
      simulator = ToyRobotSimulator::Simulator.new
      expect{ simulator.place(0,0, "WRONGFACING") }.to raise_error ToyRobotSimulator::InvalidFacingError
    end
  end
end
