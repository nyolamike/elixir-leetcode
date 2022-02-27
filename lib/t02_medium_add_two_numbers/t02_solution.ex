# Definition for singly-linked list.
#
# defmodule ListNode do
#   @type t :: %__MODULE__{
#           val: integer,
#           next: ListNode.t() | nil
#         }
#   defstruct val: 0, next: nil
# end

defmodule Solution do
  @spec add_two_numbers(l1 :: ListNode.t | nil, l2 :: ListNode.t | nil) :: ListNode.t | nil
  def add_two_numbers(l1, l2) do
    add_nodes(l1, l2, 0, nil)
    |>Enum.reverse()
    |>get_answer()
  end

  def get_answer([]), do: nil
  def get_answer([head | tail]) do
      %ListNode{
          val: head,
          next: get_answer(tail)
      }
  end

  def add_nodes(nil, nil, carry, ans_node) do
      if ans_node == nil do
          [carry]
        else
          if carry > 0, do: [carry | ans_node], else: ans_node
        end
  end

  def add_nodes(l1_node, l2_node, carry, ans_node) do
      v1 = if l1_node != nil, do: l1_node.val, else: 0
      v2 = if l2_node != nil, do: l2_node.val, else: 0
      v3 = carry + v1 + v2
      {num, carry}  = if v3 < 10, do: {v3,0}, else: { rem(v3, 10), div(v3, 10) }
      ans_node =
        if ans_node == nil do
           [num]
        else
           [num | ans_node]
        end
      next1 = if l1_node != nil, do: l1_node.next, else: nil
      next2 = if l2_node != nil, do: l2_node.next, else: nil
      add_nodes(next1, next2, carry, ans_node)
  end
end
