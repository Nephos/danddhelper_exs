defmodule RollParserError do
  defexception message: "Cannot parse the Roll"
end

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
    %Roll{dice: parse([], str, "+")}
  end

  def parse_first_die(str) do
    # (Sign? Value) (NSign Rest)?
    Regex.named_captures(~r/^ *(?<sign>[\+\-])? *(?<value>(\d+d\d+)|(\d+))(?<rest>( *(?<rest_sign>[\+\-])? *((\d+d\d+)|(\d+)))*) *$/i, str)
  end

  def parse(roll, rest, sign) when is_list(roll) and is_bitstring(rest) and is_bitstring(sign) do
    cap = parse_first_die(rest)
    if is_nil(cap["value"]) do
      raise RollParserError, "Cannot parse the dice `#{rest}`: sign=#{cap["sign"]} value=#{cap["value"]} next_sign=#{cap["next_sign"]} rest=#{cap["rest"]}"
    end

    # value = `Dice` parsed from the string
    value = Dice.new(cap["value"])
    if sign == "-" and cap["sign"] != "-" do
      value = Dice.neg(value)
    end

    # rest = remaining not parsed `String`
    cond do
      String.length(cap["rest"]) == 0 ->
        roll ++ [value]
      true ->
        parse(roll ++ [value], cap["rest"], cap["rest_sign"])
    end
  end

  @doc """
  Returns: `Integer` random based on the `Dice` stored
  """
  def test(roll, details\\false, stringify\\false) do
    values = Enum.map(roll.dice, fn(e) ->
      Dice.test(e)
    end)
    if details == false do
      Enum.sum(values)
    else
      if stringify == true do
        str = Enum.reduce(values, nil, fn(right, left) ->
          if is_nil(left) do "#{right}" else "#{right}, #{left}" end
        end)
        total = Enum.sum(values)
        "#{str} = #{total}"
      else
        values
      end
    end
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
