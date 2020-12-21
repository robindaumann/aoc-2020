defmodule Input do
  defmacro path(suffix \\ ".txt") do
    quote do
      Path.join([File.cwd!(), "input", Path.basename(__ENV__.file, "_test.exs") <> unquote(suffix)])
    end
  end

  defmacro example() do
    quote do
      Input.path("_example.txt")
    end
  end

  @doc """
    Prints out a description and a content unless we are in CI
  """
  def show(desc, content) do
    unless System.get_env("GITHUB_ACTION") do
      IO.puts("\n#{desc}")
      IO.write(content)
    end

    content
  end

  def read_numbers(path) do
    path
    |> File.stream!()
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&String.to_integer/1)
  end
end
