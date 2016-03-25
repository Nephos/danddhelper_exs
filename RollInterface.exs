defmodule RollInterface do

  def infinite_loop(objs\\%{}) do
    IO.puts ""

    input = String.strip(IO.gets("Input a roll: "))

    cond do
      Regex.match? ~r/^e(x(it)?)?$/, input ->
        objs

      cap = Regex.named_captures(~r/^d(el(ete)?)? (?<name>[A-Za-z]\w*)$/, input) ->
        objs = Map.delete(objs, cap["name"])
        IO.puts "***** Deleted #{cap["name"]} *****"
        infinite_loop(objs)

      input == "" ->
        IO.puts ""
        Enum.map(Map.keys(objs), fn(o_name) ->
          IO.puts "***** #{o_name} *****\t #{Roll.to_string(objs[o_name])} ... #{Roll.test(objs[o_name], true, true)}"
        end)
        infinite_loop(objs)

      true ->
        cap = Regex.named_captures(~r/^(?<name>[A-Za-z]\w*) +(?<roll>.+)$/, input)
        add_obj = !is_nil(cap)
        IO.puts "add_obj:#{add_obj}, name:#{cap["name"]}, roll:#{cap["roll"]}"

        input = cond do
          add_obj -> cap["roll"]
          true -> input
        end

        roll = try do
          roll = Roll.new(input)
          IO.puts "#{Roll.to_string(roll)} ... #{Roll.test(roll, true, true)}"
          roll
        rescue
          e in RollParserError -> IO.puts e.message
        end
        objs = cond do
          add_obj -> Map.put(objs, cap["name"], roll)
          true -> objs
        end

        infinite_loop(objs)
    end


  end

end
