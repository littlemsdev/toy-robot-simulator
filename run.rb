require_relative "lib/toy-robot-simulator/command"

puts "WELCOME TO TOY ROBOT SIMULATOR - CHARLENE TAW"
puts "Issue command to the robot or type in 'HELP' for instructions."

input = ""

while input != "EXIT" do
  print ">> "
  input = gets.chomp
  puts ToyRobotSimulator::Command.command(input)
  puts "Type another command please"
end
