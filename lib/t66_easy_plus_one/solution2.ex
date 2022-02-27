defmodule Solution2 do
  @spec plus_one(digits :: [integer]) :: [integer]
  def plus_one(digits) do
     digits |> Enum.reverse() |> get_tail(1) |> Enum.reverse()
  end

  def get_tail([], 0), do: []
  def get_tail([], carry), do: [carry]
  def get_tail([ head | tail ], carry) do
     sum = head + carry
     if sum > 9 do
        num = rem(sum, 10)
        carry = div(sum, 10)
        [num] ++ get_tail(tail,carry)
     else
        [sum] ++ tail
     end
  end
end
