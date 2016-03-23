defmodule RollInterface do

  def infinite_loop do
    input = IO.gets "Input a roll: "

    roll = Roll.new(input)

    IO.puts "#{Roll.to_string(roll)} ... #{Roll.test(roll)}"
    IO.puts ""

    infinite_loop()
  end
end
