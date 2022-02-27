defmodule Solution448 do
  @spec find_disappeared_numbers(nums :: [integer]) :: [integer]
  def find_disappeared_numbers(nums) do
      #the length of an the list is n
      #so we go through the list but checking for number that are below or equal to n
      #but these numbers are not in the list

      #we need to reduce
      tally = {
        %{},
        0
      }
      {checks, _} = nums |> Enum.reduce(tally, fn num, {checks, len} ->
         len = len + 1
         checks = checks |> put_item(num) |> put_item(len,0)
         {checks, len}
      end)
      #get keys with zero count
      checks |> Enum.reduce([], fn {key, value}, acc ->
        if value == 0, do: [key | acc], else: acc
      end)
  end
  def put_item(checks, num, increment \\ 1) do
      if checks |> Map.has_key?(num) == false do
          checks |> Map.put(num, increment)
      else
          checks |> Map.put(num, checks[num] + increment)
      end
  end
end
