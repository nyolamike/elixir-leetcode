defmodule SlidingMirrorEx do
  def run() do
    list = "iwasgoingtotownyesterdayj"
    IO.puts(list)

    {track, i, j, xter, word, glossary, all} =
      for <<x::utf8 <- list>>, reduce: {%{}, 0, 0, nil, [], %{}, []} do
        {track, i, j, xter, word, glossary, all} ->
          xter = <<x>>

          {i, word, glossary, all} =
            cond do
              track |> Map.has_key?(xter) and track[xter] >= i ->
                extract_frame(i, j, xter, word, glossary, all, track)
              true ->
                {i, word, glossary, all}
            end

          # update tracker with current index of letter
          track = track |> Map.update(xter, j, fn _ -> j end)
          word = [<<x>> | word]

          {track, i, j + 1, xter, word, glossary, all}
      end

    #remove the last frame
    {i, seed_word, glossary, all} = extract_frame(i, j, xter, word, glossary, all, track)
    {i, j, seed_word, glossary, all}
    # 6  5 4 3 2 1 0
    # i [o,g,s,a,w,i]
    # j = 6
    # i = 0
    # L = j - i (6 - 0=>6)
    # G = iwasgo
    # next seed word whats if
    # 6  5 4 3 2 1 0
    # i [o,g,i,a,w,k] =>
  end

  def extract_frame(i, j, xter, word, glossary, all, track) do
    # length of current word
    len = j - i
    # push generatd word into glossary
    gen_word = word |> Enum.reverse() |> Enum.join()

    glossary =
      Map.update(glossary, gen_word, {len, 1}, fn {len, count} -> {len, count + 1} end)

    all = [gen_word | all]

    # get the seeding word for the next iteration
    # get index of letter from tracker, and make it current index of i
    i = track[xter]
    new_len = j - (i + 1)
    seed_word = word |> Enum.take(new_len)

    # if gen_word == "ot" do
    #   require IEx
    #   IEx.pry()
    # end

    {i + 1, seed_word, glossary, all}
  end
end
