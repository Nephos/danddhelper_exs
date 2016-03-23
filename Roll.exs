defmodule Roll do
  @moduledoc """
  `Roll` is a structure that contain a list of dice
  """
  defstruct dice: []

  # note: when implement `Enum` instead of is_list ?
  @doc """
  Constructor
  returns a `Dice` struct having every values specified in parameter
  """
  def new(str) when is_bitstring(str) do
    %Roll{dice: parse([], str)}
  end

  def parse(dice, rest) when is_list(dice) and is_bitstring(rest) do
    # rest = remaining not parsed `String`
    # dice = `Dice` parsed from the string
    cap = Regex.named_captures(~r/(?<value>((\d+(d|D)\d+)|(\d+))) *(?<rest>.*)/, rest)
    die = Dice.new(cap["value"])
    rest = String.strip(cap["rest"])
    cap = Regex.named_captures(~r/(?<sign>[\-\+]) ?(?<rest>.+)/, rest)
    # if there is a malus
    if cap["sign"] == "-" do
      Dice.neg(die)
    end
    # parse the rest
    rest = cap["rest"]
    parse(dice ++ [die], rest)
  end

  # parsing ending
  def parse(dice, rest) when is_list(dice) and is_nil(rest) do
    dice
  end

  @doc """
  Returns: `Integer` random based on the `Dice` stored
  """
  def test(roll) do
    Enum.reduce(roll.dice, 0, fn(right, left) ->
      left + Dice.test(right)
    end)
  end

  def to_string(roll) do
    Enum.reduce(roll.dice, nil, fn(right, left) ->
      cond do
        is_nil(left) ->
          Dice.to_string(right)
        true ->
          "#{left} + #{Dice.to_string(right)}"
      end
    end)
  end

end
