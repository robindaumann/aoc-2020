defmodule Day17 do
  def part1(path) do
    solve(path, 3)
  end

  def part2(path) do
    solve(path, 4)
  end

  def solve(path, dimensions) do
    directions = directions(dimensions)

    path
    |> Input.read_grid(fn cell -> cell == "#" end)
    |> Map.fetch!(:grid)
    # We work with lists for the coordinates here, such that
    # we can generalize some 3d and 4d operations
    |> Enum.map(fn {{x, y}, _cell} -> [x, y] ++ List.duplicate(0, dimensions - 2) end)
    |> MapSet.new()
    |> simulate(directions, 6)
  end

  def simulate(grid, _directions, 0) do
    Enum.count(grid)
  end

  def simulate(grid, directions, steps) do
    grid
    |> bounds()
    |> coords()
    |> Enum.flat_map(&step(grid, &1, directions))
    |> MapSet.new()
    |> simulate(directions, steps - 1)
  end

  def step(grid, coords, directions) do
    neighbours = count_neighbours(grid, coords, directions)
    active? = MapSet.member?(grid, coords)

    if neighbours == 3 or (neighbours == 2 and active?) do
      [coords]
    else
      []
    end
  end

  def count_neighbours(grid, coords, directions) do
    Enum.count(directions, fn dir ->
      pos = zip_map(coords, dir, &+/2)
      MapSet.member?(grid, pos)
    end)
  end

  def directions(dimensions) do
    Math.cartesian([-1..1], repeat: dimensions)
    |> Enum.reject(fn coords ->
      Enum.all?(coords, &(&1 == 0))
    end)
  end

  def coords(ranges) do
    Math.cartesian(ranges)
  end

  def bounds(grid) do
    mins =
      Enum.reduce(grid, fn coord, min -> zip_map(coord, min, &min/2) end)
      |> Enum.map(&(&1 - 1))

    maxs =
      Enum.reduce(grid, fn coord, min -> zip_map(coord, min, &max/2) end)
      |> Enum.map(&(&1 + 1))

    zip_map(mins, maxs, &Range.new/2)
  end

  def zip_map(l1, l2, f) do
    Enum.zip(l1, l2)
    |> Enum.map(fn args -> apply(f, Tuple.to_list(args)) end)
  end
end
