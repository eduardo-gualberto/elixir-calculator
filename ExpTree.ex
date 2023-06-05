defmodule ExpTree do
  @moduledoc """
  Implements the Expression Tree data structure as simple as possible
  Tree Node(node) props: data: String, left: node?, right: node?
  """
  @type tree_node :: %{data: String, left: tree_node | nil, right: tree_node | nil}

  @spec new(String) :: tree_node
  defp new(data) do
    %{data: data, left: nil, right: nil}
  end

  @spec operand(tree_node, tree_node, String) :: tree_node
  defp operand(node_left, node_right, data) do
    %{data: data, left: node_left, right: node_right}
  end

  @spec build_tree(String) :: [any]
  def build_tree(exp), do: _build_tree(String.split(exp, "\s"), [])

  @spec _build_tree([String], [any]) :: [any]
  defp _build_tree([], [tree | []]), do: tree
  defp _build_tree([], _), do: raise("Invalid Expression")

  defp _build_tree([token | exp], stack) when token in ["+", "-", "*", "/", "^"] do
    {right, stack} = List.pop_at(stack, -1)
    {left, stack} = List.pop_at(stack, -1)
    node = operand(left, right, token)
    _build_tree(exp, Enum.concat(stack, [node]))
  end

  defp _build_tree([token | exp], stack) do
    node = new(token)
    _build_tree(exp, Enum.concat(stack, [node]))
  end

  @spec eval_exp(tree_node) :: float
  def eval_exp(node) do
    eval(node)
  end

  @spec eval(tree_node) :: float
  defp eval(%{data: token, left: left, right: right}) when token in ["+", "-", "*", "/", "^"] do
    case token do
      "+" -> eval(left) + eval(right)
      "-" -> eval(left) - eval(right)
      "*" -> eval(left) * eval(right)
      "/" -> eval(left) / eval(right)
      "^" -> Float.pow(eval(left), eval(right))
    end
  end

  defp eval(%{data: token, left: nil, right: nil}) do
    try do
      String.to_float(token)
    rescue
      _ in ArgumentError -> String.to_integer(token) * 1.0
    end
  end

  @spec eval_exp(tree_node, any) :: float
  def eval_exp(node, var_map) do
    eval(node, var_map)
  end

  defp eval(%{data: token, left: left, right: right}, var_map)
       when token in ["+", "-", "*", "/", "^"] do
    case token do
      "+" -> eval(left, var_map) + eval(right, var_map)
      "-" -> eval(left, var_map) - eval(right, var_map)
      "*" -> eval(left, var_map) * eval(right, var_map)
      "/" -> eval(left, var_map) / eval(right, var_map)
      "^" -> Float.pow(eval(left, var_map), eval(right, var_map))
    end
  end

  defp eval(node = %{data: token, left: nil, right: nil}, var_map) do
    if String.match?(token, ~r/[0-9]+(\.[0-9]+)?/) do
      eval(node)
    else
      if token not in Map.keys(var_map) do
        raise "Invalid attribution"
      end

      val = Map.get(var_map, token)

      try do
        String.to_float(val)
      rescue
        _ in ArgumentError -> String.to_integer(val) * 1.0
        true -> raise "Invalid attribution"
      end
    end
  end
end
