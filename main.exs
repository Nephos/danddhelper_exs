require Code
Code.load_file("Dice.exs")
Code.load_file("Roll.exs")

sword = Roll.new("1d8+1")

IO.puts "#{Roll.to_string(sword)} ... #{Roll.test(sword)}"
