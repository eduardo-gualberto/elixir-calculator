defmodule ExpFormatter do

  @spec format_exp(String) :: String
  def format_exp(exp) do
    _format_exp(exp)
  end

  defp _format_exp(exp) do
    import String, only: [replace: 3, trim: 1]
    replace(exp, ~r/\s+/, "")                                                        # strip spaces
    |> replace(~r/\++/, "+")                                                         # multiple '+'s
    |> replace(~r/(--)+/, "+")                                                       # canceling '-'s
    |> replace(~r/(\+-)+/, "-")                                                      # '+-' equals '-'
    |> replace(["+", "-", "*", "/", "^", "(", ")"], fn op -> " " <> op <> " " end)   # spaces around operators ("*" -> " * ")
    |> replace(~r/\s+/, " ")                                                         # remove duplicate spaces
    |> trim                                                                          # remove leading/trailing spaces
  end

end
