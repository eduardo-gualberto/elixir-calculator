defmodule ExpParser do
  @moduledoc """
  Implementes algorithms for parsing expression string
  """

  @spec convert_to_postfix(String) :: String
  def convert_to_postfix(exp_str) do
    exp_list = String.split(exp_str, "\s")
    post_fix_exp = _convert(exp_list, [], [])
    Enum.join(post_fix_exp, " ")
  end

  # for base case
  defp _convert([], converted, []) do
    converted
  end
  defp _convert([], converted, stack) do
    {popped, stack} = List.pop_at(stack, -1)

    if popped === "(" do
      raise "Invalid Expression"
    end

    _convert([], converted ++ [popped], stack)
  end

  # for operator
  defp _convert([token | exp], converted, []) when token in ["+", "-", "*", "/", "^"] do
    _convert(exp, converted, [token])
  end
  defp _convert([token | exp], converted, stack) when token in ["+", "-", "*", "/", "^"] do
    cond do
      precedence(List.last(stack)) >= precedence(token) ->
        {popped, stack} = List.pop_at(stack, -1)
        _convert([token | exp], converted ++ [popped], stack)

      true ->
        _convert(exp, converted, stack ++ [token])
    end
  end

  # for open paren
  defp _convert([token | exp], converted, stack) when token === "(" do
    _convert(exp, converted, stack ++ [token])
  end

  # for close paren
  defp _convert([token | exp], converted, []) when token === ")" do
    _convert(exp, converted, [])
  end
  defp _convert([token | exp], converted, stack) when token === ")" do
    cond do
      List.last(stack) !== "(" ->
        {popped, stack} = List.pop_at(stack, -1)
        _convert([token | exp], converted ++ [popped], stack)

      true ->
        {_, stack} = List.pop_at(stack, -1)
        _convert(exp, converted, stack)
    end
  end

  # for operand
  defp _convert([token | exp], converted, stack) do
    _convert(exp, converted ++ [token], stack)
  end

  @spec precedence(String) :: integer
  defp precedence(token) when token in ["+", "-"], do: 1
  defp precedence(token) when token in ["*", "/"], do: 2
  defp precedence(token) when token in ["^"], do: 3
  defp precedence(_), do: -1
end
