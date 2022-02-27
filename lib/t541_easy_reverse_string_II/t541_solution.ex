defmodule T541Solution do
  @spec reverse_str(s :: String.t, k :: integer) :: String.t
  def reverse_str(s, k) do
    tk = 2*k
    acct =
        for <<x <- s>>, reduce: %{j: -1, m: -1, jl: [], ml: [], ans: ""} do acc ->
            ptr = acc.j + 1
            {j, m, jl, ml, ans} =
                cond do
                    ptr == (tk-1) ->
                            jl = [<<x>> | acc.jl]
                            ml_str = Enum.join(acc.ml)
                            jl_str = Enum.reverse(jl) |> Enum.join()
                            ans = acc.ans <> ml_str <> jl_str
                            {-1, -1, [], [], ans}
                    true ->
                        { m, ml, jl } =
                            if acc.m < (k-1) do
                                ml = [<<x>> | acc.ml]
                                {acc.m + 1, ml, acc.jl }
                            else
                                jl = [<<x>> | acc.jl]
                                { acc.m, acc.ml, jl }
                            end

                        {ptr, m, jl, ml, acc.ans}
                end


            %{acc | j: j, m: m, jl: jl, ml: ml, ans: ans}
        end
    left_chars_ml = (acct.m + 1)
    left_chars_jl = if acct.j <= acct.m, do: 0, else: acct.j - acct.m
    left_chars =  left_chars_ml +  left_chars_jl
    last_str =
        if left_chars < k do
            acct.ml |> Enum.join()
        else
            if left_chars < tk and left_chars >= k do
                    ml_str  = acct.ml |> Enum.join()
                    jl_str = Enum.reverse(acct.jl) |> Enum.join()
                    ml_str <> jl_str
            else
                ""
            end
        end
    #str = acct.ans <> last_str
    #%{acct | ans: str}
    acct.ans <> last_str
  end
end

#my first attempt
# defmodule SolutionXX do
#   @spec reverse_str(s :: String.t, k :: integer) :: String.t
#   def reverse_str(s, k) do
#     { j, current_word, skip, ans, cwl} =
#         for <<x <- s>>, reduce: {1, [], false, [], 0}  do { j, current_word, skip, ans, cwl} ->
#            {j, current_word, skip, ans, cwl}  =
#                if j > k do
#                  {current_word, skip} =
#                      #change of direction
#                      if skip == true do
#                         {current_word, false}
#                      else
#                         {Enum.reverse(current_word), true}
#                      end
#                  #append to answer
#                  ans = current_word ++ ans
#                  { 1, [], skip, ans, 0}
#                else
#                  { j, current_word, skip, ans, cwl}
#                end
#            current_word = [<<x>> | current_word]
#            {j+1, current_word, skip, ans, cwl + 1}
#         end

#     ans = current_word ++ ans
#     ans |> Enum.reverse() |> Enum.join()
#   end
# end
