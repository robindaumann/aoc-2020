defmodule Input do
  defmacro path(suffix \\ ".txt") do
    quote do
      Path.join([
        File.cwd!(),
        "input",
        Path.basename(__ENV__.file, "_test.exs") <> unquote(suffix)
      ])
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
  @spec show(String.t(), String.t()) :: String.t()
  def show(desc, content) do
    unless System.get_env("GITHUB_ACTION") do
      IO.puts("\n#{desc}")
      IO.write(content)
    end

    content
  end

  @spec read_numbers(Path.t()) :: [integer()]
  def read_numbers(path) do
    path
    |> File.stream!()
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&String.to_integer/1)
  end

  @type coord() :: {non_neg_integer(), non_neg_integer()}
  @type cell() :: atom()
  @type grid() :: %{grid: %{coord() => cell()}, width: non_neg_integer(), height: non_neg_integer()}
  @spec read_grid(Path.t(), (String.t() -> boolean())) :: grid()
  def read_grid(path, cell_filter \\ &always/1) do
    rows =
      path
      |> File.stream!()
      |> Enum.map(&String.trim_trailing/1)

    height = Enum.count(rows)
    width = List.first(rows) |> String.length()

    grid =
      rows
      |> Enum.with_index()
      |> Enum.flat_map(&parseRow(&1, cell_filter))
      |> Map.new()

    %{grid: grid, width: width, height: height}
  end

  defp parseRow({row, y}, cell_filter) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.filter(fn {cell, _x} -> cell_filter.(cell) end)
    |> Enum.map(fn {cell, x} -> {{x, y}, String.to_atom(cell)} end)
  end

  defp always(_), do: true
end
