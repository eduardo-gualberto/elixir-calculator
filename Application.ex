import ExpFormatter, only: [format_exp: 1]
import ExpParser, only: [convert_to_postfix: 1]
import ExpTree, only: [build_tree: 1, eval_exp: 2]

defmodule App do
  @typep app_state :: %{control: :exit | :continue | :invalid, var_map: any | nil}
  defp operators, do: ["+", "-", "*", "/", "^"]

  @spec run(app_state) :: app_state
  def run(state \\ %{control: :continue, var_map: %{}})

  def run(state) when state.control === :exit,
    do: %{control: :exit}

  def run(state) when state.control === :invalid do
    IO.puts("could not process the input above")
    run(%{state | control: :continue})
  end

  def run(state) do
    IO.inspect(state)
    IO.gets(:stdio, "") |> String.trim() |> to_runner(state) |> run
  end

  @spec to_runner(String, app_state) :: app_state
  defp to_runner(input_raw, state) do
    cond do
      String.starts_with?(input_raw, "/") -> run_cmd(input_raw, state)
      String.contains?(input_raw, "=") -> run_attr(input_raw, state)
      true -> run_exp(input_raw, state)
    end
  end

  @spec run_exp(String, app_state) :: app_state
  defp run_exp(input_raw, state) do
    try do
      input_raw
      |> String.trim()
      |> format_exp
      |> convert_to_postfix
      |> build_tree
      |> eval_exp(state.var_map)
      |> (fn exp -> IO.puts("result: #{exp}") end).()

      %{state | control: :continue}
    rescue
      e -> %{state | control: :invalid}
    end
  end

  @spec run_attr(String, app_state) :: app_state
  defp run_attr(input_raw, state) do
    import String, only: [replace: 3, trim: 1, split: 2]
    [var, val] = input_raw |> trim |> replace(~r/\s+/, "") |> split("=")

    val =
      val
      |> format_exp
      |> convert_to_postfix
      |> build_tree
      |> eval_exp(state.var_map)
      |> Float.to_string()

    %{state | var_map: Map.put(state.var_map, var, val)}
  end

  @spec run_cmd(String, app_state) :: app_state
  defp run_cmd(input_raw, state) when input_raw === "/exit" do
    IO.puts("exiting...")
    %{state | control: :exit}
  end

  defp run_cmd(input_raw, state) when input_raw === "/help" do
    IO.puts("Hey, this is a helpful text about the usage of the application")
    %{state | control: :continue}
  end

  defp run_cmd(input_raw, state) when input_raw === "/clear" do
    IO.write(:stdio, "\u001B[2J\u001B[0;0f")
    %{state | control: :continue}
  end

  defp run_cmd(input_raw, state) when input_raw === "/erase" do
    %{state | var_map: Map.new()}
  end

  defp run_cmd(_, state), do: %{state | control: :invalid}
end
