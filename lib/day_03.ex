defmodule Day03 do
  def part1(path) do
    {points, width, height} = parse(path)

    trace(points, {0, 0}, {3, 1}, width, height)
  end

  def part2(path) do
    {points, width, height} = parse(path)

    slopes = [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]

    slopes
    |> Enum.map(&trace(points, {0, 0}, &1, width, height))
    |> Enum.reduce(&*/2)
  end

  def parse(path) do
    rows =
      path
      |> File.stream!()
      |> Enum.map(&String.trim/1)

    height = Enum.count(rows)
    width = List.first(rows) |> String.length()

    points =
      rows
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, y} -> parseRow(row, y) end)
      |> MapSet.new()

    {points, width, height}
  end

  def parseRow(row, y) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce([], fn {e, x}, acc ->
      if e == "#" do
        [{x, y} | acc]
      else
        acc
      end
    end)
  end

  def trace(points, {x, y} = point, {dx, dy} = slope, width, height) when y < height do
    hit = if is_tree?(points, point, width), do: 1, else: 0

    hit + trace(points, {x + dx, y + dy}, slope, width, height)
  end

  def trace(_, _, _, _, _) do
    0
  end

  def is_tree?(points, {x, y}, width) do
    x_n = rem(x, width)
    MapSet.member?(points, {x_n, y})
  end
end
