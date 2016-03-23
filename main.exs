require Code
Code.load_file("Dice.exs")
Code.load_file("Roll.exs")
Code.load_file("RollInterface.exs")

RollInterface.infinite_loop
sword = Roll.new("1d8+1")

IO.puts "#{Roll.to_string(sword)} ... #{Roll.test(sword)}"
