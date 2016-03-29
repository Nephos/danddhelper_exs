defmodule OptiInterface do

  def infinite_loop() do
    IO.puts ""

    input = String.strip(IO.gets("Input a command: "))

    cond do
      Regex.match? ~r/^e(x(it)?)?$/, input ->
        IO.puts

      Regex.match? ~r/^h(elp)?$/, input ->
        IO.puts "Help>"
        IO.puts ""
        IO.puts "cmd ? ?/?/... ?D? + ?"
        IO.puts "max CA attack_bonus attack_damages"
        IO.puts "min CA attack_bonus attack_damages"
        IO.puts "mean CA attack_bonus attack_damages"
        infinite_loop()

      Regex.match? ~r/max .+/, input ->
        cap = Regex.named_captures(~r/\w+ (?<armor>\d+) (?<bonus>([\+\-]?\d+)(\/([\+\-]?\d+))*) (?<damages>.+)/, input)
        roll = Roll.new(cap["damages"])
        armor = (String.to_integer(cap["armor"])) * 0.05
        bonus = Attack.parse(cap["bonus"])
        IO.puts Roll.to_string(roll)
        IO.puts Enum.map(bonus, fn(e) -> Integer.to_string(e) end)
        bonus = Enum.map(bonus, fn(e) -> (0.5 + (e * 0.05) - armor) end)

        infinite_loop()

      true ->
        infinite_loop()

    end


  end

end
