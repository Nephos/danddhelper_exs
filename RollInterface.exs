defmodule RollInterface do

  def infinite_loop do
    input = String.strip(IO.gets("Input a roll: "))

    cond do
      Regex.match? ~r/^e(x(it)?)?$/, input ->
        :ok
      true ->
        try do
          roll = Roll.new(input)
          IO.puts "#{Roll.to_string(roll)} ... #{Roll.test(roll, true, true)}"
        rescue
          e in RollParserError -> IO.puts e.message
        end
        IO.puts ""
        infinite_loop()
    end


  end

end
