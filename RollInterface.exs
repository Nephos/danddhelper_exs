defmodule RollInterface do

  def infinite_loop do
    input = IO.gets "Input a roll: "

    cond do
      input == "exit\n" ->
        :ok
      true ->
        roll = Roll.new(String.trim_trailing(input, "\n"))
        IO.puts "#{Roll.to_string(roll)} ... #{Roll.test(roll, true, true)}"
        IO.puts ""
        infinite_loop()
    end


  end

end
