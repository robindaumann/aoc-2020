defmodule Day03 do
  def part1(path) do
    %{grid: points, width: width, height: height} = Input.read_grid(path, &cell_filter/1)

    trace(points, {0, 0}, {3, 1}, width, height)
  end

  def part2(path) do
    %{grid: points, width: width, height: height} = Input.read_grid(path, &cell_filter/1)

    slopes = [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]

    slopes
    |> Enum.map(&trace(points, {0, 0}, &1, width, height))
    |> Enum.reduce(&*/2)
  end

  def cell_filter(cell), do: cell == "#"

  def trace(points, {x, y} = point, {dx, dy} = slope, width, height) when y < height do
    hit = if is_tree?(points, point, width), do: 1, else: 0

    hit + trace(points, {x + dx, y + dy}, slope, width, height)
  end

  def trace(_, _, _, _, _) do
    0
  end

  def is_tree?(points, {x, y}, width) do
    x_n = rem(x, width)
    Map.has_key?(points, {x_n, y})
  end
end
