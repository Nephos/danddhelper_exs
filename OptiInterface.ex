defmodule OptiInterface do

  def infinite_loop(average_touch\\10.5) when is_float(average_touch) do
    IO.puts ""

    input = String.strip(IO.gets("Input a command: "))

    cond do
      Regex.match? ~r/^e(x(it)?)?$/, input ->
        :ok

      Regex.match? ~r/^average(_touch)? = (\d+(\.\d+)?)$/, input ->
        cap = Regex.named_captures(~r/\w+ = (?<average_touch>\d+(\.\d+)?)/, input)
        average_touch = cond do
          Regex.match? ~r/^\d+\.\d+$/, cap["average_touch"] -> String.to_float(cap["average_touch"])
          Regex.match? ~r/^\d+$/, cap["average_touch"] -> String.to_integer(cap["average_touch"])
          true -> raise "What the fuck"
        end
        IO.puts "Set average_touch = #{average_touch * 100 * 0.05} %"
        infinite_loop(average_touch * 1.0)

      Regex.match? ~r/^h(elp)?$/, input ->
        IO.puts "Help>"
        IO.puts ""
        IO.puts "average_touch = ?"
        IO.puts ""
        IO.puts "cmd ? ?/?/... ?D? + ?"
        IO.puts "max CA attack_bonus attack_damages"
        IO.puts "min CA attack_bonus attack_damages"
        IO.puts "mean CA attack_bonus attack_damages"
        infinite_loop(average_touch)

      Regex.match? ~r/(max|min|mean) .+/, input ->
        cap = Regex.named_captures(~r/(?<cmd>\w+) (?<armor>\d+) (?<bonus>([\+\-]?\d+)(\/([\+\-]?\d+))*) (?<damages>.+)/, input)
        roll = Roll.new(cap["damages"])
        armor = (String.to_integer(cap["armor"]))
        bonus = Attack.parse(cap["bonus"])
        bonus = Enum.map(bonus, fn(e) -> Enum.max([0.0, Enum.min([1.0, (average_touch * 0.100) + (e * 0.05) - (armor * 0.05)])]) end)
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

        infinite_loop(average_touch)

      true ->
        infinite_loop(average_touch)

    end


  end

end
