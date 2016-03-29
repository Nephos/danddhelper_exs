defmodule Attack do
  def parse(str) when is_bitstring(str) do
    parse(str, [])
  end

  def parse(str, bonus) when is_bitstring(str) and is_list(bonus) do
    cap = Regex.named_captures(~r/^(?<current>[\+\-]?\d+)(?<next>(\/([\+\-]?\d+))*)/, str)
    cond do
      is_nil(cap) ->
        bonus
      true ->
        parse(String.trim_leading(cap["next"], "/"), bonus ++ [String.to_integer(cap["current"])])
    end
  end
end
