defmodule Solution do
  @spec multiply(num1 :: String.t, num2 :: String.t) :: String.t
  def multiply(num1, num2) do
     num1_int = to_number(num1)
     num2val = to_number(num2)
     res = num1_int * num2val
     to_string(res)
  end

  def to_number(str) do
      rev_str = String.reverse(str)
      {res, _} = rev_str |> String.graphemes |> Enum.reduce({0,-1}, fn char, {num, place} ->
        char_val = val(char)
        place = place + 1
        place_value = 10**place
        new_number = place_value * char_val
        {num + new_number, place}
      end)
      res
  end

  def val("0"), do: 0
  def val("1"), do: 1
  def val("2"), do: 2
  def val("3"), do: 3
  def val("4"), do: 4
  def val("5"), do: 5
  def val("6"), do: 6
  def val("7"), do: 7
  def val("8"), do: 8
  def val("9"), do: 9
end
