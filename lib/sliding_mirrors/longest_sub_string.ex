defmodule LongestSubString do

  # "iwasgoingtotownyesterday"
  @spec digest(input::String) ::Map
  def digest(input) do

    tally = %{
      track: %{},
      i: 0,
      j: 0,
      current_letter: nil,
      current_word: [],
      glossary: %{},
      all: [],
      diff: 0
    }

    IO.puts(input)

    acc =
      for <<x <- input>>, reduce: tally do
        acc ->
          acc = %{acc | current_letter: <<x>>}

          # extract the subtring
          previous_index = acc.track[acc.current_letter]

          acc =
            if acc.track |> Map.has_key?(acc.current_letter) and previous_index >= acc.i do
              extract_frame(acc, previous_index)
            else
              acc
            end

          # append the current_letter to the current word

          new_word = [acc.current_letter | acc.current_word]

          new_tracking = Map.update(acc.track, acc.current_letter, acc.j, fn _ -> acc.j end)
          %{acc | track: new_tracking, j: acc.j + 1, current_word: new_word}
      end

    extract_frame(acc, acc.track[acc.current_letter])
  end

  def extract_frame(acc, previous_index) do
    len = acc.j - acc.i
    greatest_diff = if len > acc.diff, do: len, else: acc.diff
    sub_string = acc.current_word |> Enum.reverse() |> Enum.join()

    new_glossary =
      acc.glossary
      |> Map.update(sub_string, {len, 1}, fn {len, count} ->
        {len, count + 1}
      end)

    # do the jump
    i = previous_index + 1
    jump_len = acc.j - i
    seeding_word = acc.current_word |> Enum.take(jump_len)

    %{
      acc
      | diff: greatest_diff,
        i: i,
        glossary: new_glossary,
        all: [sub_string | acc.all],
        current_word: seeding_word
    }
  end
end
