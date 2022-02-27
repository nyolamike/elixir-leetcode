defmodule T03Solution do
  @spec length_of_longest_substring(s :: String.t) :: integer
  def length_of_longest_substring(s) do
    # longest_length = 0
    blen = 0
    #i & j both start at index 0
    i= 0
    j= 0
    #go through each xter in the list
    {i, j, track, blen} =
        for <<x <- s>>, reduce: {i,j,%{},blen} do {i, j, track, blen} ->
            #check if the xter is already visited and its previous index >= i
            {i, j, track, blen} =
                if Map.has_key?(track,<<x>>) and track[<<x>>] >= i do
                   #length between j & i
                   #len = j - i
                   #blen = if len > blen, do: len, else: blen
                   blen = update_blen(i, j, blen)
                   i = track[<<x>>] + 1
                   {i, j, track, blen}
                else
                   {i, j, track, blen}
                end
            track = track |> Map.update(<<x>>, j, fn _ -> j end )

            #for every iteration update j, move j foward
            {i, j + 1, track, blen}
        end
    update_blen(i, j, blen)
  end

  def update_blen(i, j, blen) do
    len = j - i
    if len > blen, do: len, else: blen
  end
end
