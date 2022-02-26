defmodule Solution1 do
  @spec plus_one(digits :: [integer]) :: [integer]
  def plus_one(digits) do
    digits
    |> Enum.join("")
    |> String.to_integer()
    |> add_one()
    |> to_string()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  @spec add_one(num :: integer) :: integer
  def add_one(num), do: num + 1

end
