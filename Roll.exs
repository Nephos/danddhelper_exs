defmodule Roll do
  @moduledoc """
  `Roll` is a structure that contains a list of dices
  """
  defstruct dices: []

  # note: when implement `Enum` instead of is_list ?
  @doc """
  Constructor
  returns a `Dice` struct having every values specified in parameter
  """
  def new(str) when is_bitstring(str) do
    %Roll{dices: parse([], str)}
  end

  def parse(dices, rest) when is_list(dices) and is_bitstring(rest) do
    # rest = remaining not parsed `String`
    # dice = `Dice` parsed from the string
    cap = Regex.named_captures(~r/(?<value>((\d+(d|D)\d+)|(\d+))) *(?<rest>.*)/, rest)
    dice = Dice.new(cap["value"])
    rest = String.strip(cap["rest"])
    cap = Regex.named_captures(~r/(?<sign>[\-\+]) ?(?<rest>.+)/, rest)

    if cap["sign"] == "-" do
      Dice.neg(dice)
    end

    rest = cap["rest"]
    parse(dices ++ [dice], rest)
  end

  def parse(dices, rest) when is_list(dices) and is_nil(rest) do
    dices
  end

  def test(roll) do
    Enum.reduce(roll.dices, 0, fn(right, left) ->
      left + Dice.test(right)
    end)
  end

  def to_string(roll) do
    Enum.reduce(roll.dices, nil, fn(right, left) ->
      cond do
        is_nil(left) ->
          Dice.to_string(right)
        true ->
          "#{left} + #{Dice.to_string(right)}"
      end
    end)
  end

end
