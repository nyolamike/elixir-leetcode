defmodule T01Solution do
  @spec two_sum(nums :: [integer], target :: integer) :: [integer]
  def two_sum(nums, target) do
    acc = Enum.reduce_while(nums, %{diffs: %{}, indexes: %{}, i: 0, ans1: -1, ans2: -1}, fn num, track ->
        if Map.has_key?(track.diffs, num) do
            ans1 = track.diffs[num]
            ans2 = track.i
            {:halt, %{track | ans1: ans1, ans2: ans2} }
        else
            diff = target - num
            diffs = track.diffs |> Map.update(diff, track.i, fn _ -> track.i end)
            indexes = track.indexes |> Map.update(num, track.i, fn _ -> track.i end)
            {:cont, %{track | diffs: diffs, indexes: indexes, i: track.i+1}}
        end
    end)
    [acc.ans1, acc.ans2]
  end
end
