defmodule DiceMacro do
  defmacro for_every_value(name, todo) do
    quote do
      def unquote(name)(d) do
        Enum.reduce(d.values, 0, unquote(todo))
      end
    end
  end
end

defmodule Dice do
  @moduledoc """
  `Dice` is a structure that contain a constant or a random value
  """
  defstruct values: [[]]

  # note: when implement `Enum` instead of is_list ?
  @doc """
  Returns: `Dice` struct having every values specified in parameter
  """
  def new(values) when is_list(values) do
    %Dice{values: values}
  end

  @doc """
  Returns: `Dice` struct parsed from a string "nDf" or "n"
  """
  def new(str) when is_bitstring(str) do
    cond do
      str =~ ~r/\d+d\d+/i ->
        cap = Regex.named_captures(~r/(?<nb>\d+)d(?<faces>\d+)/i, str)
        nb = String.to_integer(cap["nb"])
        faces = String.to_integer(cap["faces"])
        new(Enum.map(1..nb, fn(_) ->
          Enum.to_list(1..faces)
        end))
      str =~ ~r/\d+/ ->
        new([[String.to_integer(str)]])
    end
  end

  @doc """
  Returns: `Dice` negated (every values in the `Dice` are negated)
  """
  def neg(d) do
    %Dice{values: Enum.map(d.values, fn(arr) ->
      Enum.map(arr, &(-(&1)))
    end)}
  end

  require DiceMacro
  DiceMacro.for_every_value(:test, fn(r, l) -> l + Enum.random(r) end)
  DiceMacro.for_every_value(:max, fn(r, l) -> l + Enum.max(r) end)
  DiceMacro.for_every_value(:min, fn(r, l) -> l + Enum.min(r) end)
  DiceMacro.for_every_value(:mean, fn(r, l) -> l + (Enum.min(r) + Enum.max(r)) / 2 end)

  def to_string(d) do
    cond do
      Enum.count(d.values) == 1 and Enum.count(List.first(d.values)) == 1 ->
        "#{List.first(List.first(d.values))}"
      true ->
        "#{Enum.count(d.values)}D#{Enum.count(List.first(d.values))}"
    end
  end

end
