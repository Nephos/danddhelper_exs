defmodule OptiInterface do

  def infinite_loop() do
    IO.puts ""

    input = String.strip(IO.gets("Input a command: "))

    cond do
      Regex.match? ~r/^e(x(it)?)?$/, input ->
        :ok

      Regex.match? ~r/^h(elp)?$/, input ->
        IO.puts "Help>"
        IO.puts ""
        IO.puts "cmd ? ?/?/... ?D? + ?"
        IO.puts "max CA attack_bonus attack_damages"
        IO.puts "min CA attack_bonus attack_damages"
        IO.puts "mean CA attack_bonus attack_damages"
        infinite_loop()

      Regex.match? ~r/(max|min|mean) .+/, input ->
        cap = Regex.named_captures(~r/(?<cmd>\w+) (?<armor>\d+) (?<bonus>([\+\-]?\d+)(\/([\+\-]?\d+))*) (?<damages>.+)/, input)
        roll = Roll.new(cap["damages"])
        armor = (String.to_integer(cap["armor"])) * 0.05
        bonus = Attack.parse(cap["bonus"])
        bonus = Enum.map(bonus, fn(e) -> Enum.min([1.0, 1.0 + (e * 0.05) - armor]) end)
        cmd = cap["cmd"]

        result = cond do
          cmd == "max" -> Enum.map(bonus, fn(mult) -> mult * Roll.max(roll) end)
          cmd == "min" -> Enum.map(bonus, fn(mult) -> mult * Roll.min(roll) end)
          cmd == "mean" -> Enum.map(bonus, fn(mult) -> mult * Roll.mean(roll) end)
        end

        bonus_str = Enum.join(Enum.map(bonus, fn(f) -> Float.round(f, 2) end), " / ")
        res_str = Enum.join(Enum.map(result, fn(f) -> Float.round(f, 2) end), " + ")
        tot_str = Float.round(Enum.sum(result), 2)

        IO.puts "[#{cmd}] attacks: #{bonus_str}, with #{Roll.to_string(roll)} damages => #{res_str} => #{tot_str}"

        infinite_loop()

      true ->
        infinite_loop()

    end


  end

end
