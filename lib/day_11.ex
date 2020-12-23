defmodule Day11 do
  def part1(path) do
    path
    |> parse()
    |> simulate()
    |> Enum.count(fn {_, seat} -> seat == :"#" end)
  end

  def part2(path) do
    raise "not_implemented #{path}"
  end

  def show(seats) do
    {{{min_x, _}, _}, {{max_x, _}, _}} = Enum.min_max_by(seats, fn {{x, _y}, _} -> x end)
    {{{_, min_y}, _}, {{_, max_y}, _}} = Enum.min_max_by(seats, fn {{_x, y}, _} -> y end)

    Enum.each(min_y..max_y, fn y ->
      Enum.each(min_x..max_x, fn x ->
        IO.write(Map.get(seats, {x, y}, "."))
      end)

      IO.puts("")
    end)

    IO.puts("")
    seats
  end

  def simulate(seats) do
    next = Enum.map(seats, &step(seats, &1)) |> Enum.into(%{})

    if Map.equal?(seats, next) do
      next
    else
      simulate(next)
    end
  end

  def step(seats, {pos, :L} = seat) do
    any_neighbour = Enum.any?(directions(), fn direction -> occupied?(seats, pos, direction) end)

    if any_neighbour do
      seat
    else
      {pos, :"#"}
    end
  end

  def step(seats, {pos, :"#"} = seat) do
    neighbours = Enum.count(directions(), fn direction -> occupied?(seats, pos, direction) end)

    if neighbours < 4 do
      seat
    else
      {pos, :L}
    end
  end

  def directions(), do: for(dx <- -1..1, dy <- -1..1, dx != 0 or dy != 0, do: {dx, dy})

  def occupied?(seats, {x, y}, {dx, dy}) do
    Map.get(seats, {x + dx, y + dy}) == :"#"
  end

  def parse(path) do
    path
    |> File.stream!()
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} -> parseRow(row, y) end)
    |> Enum.into(%{})
  end

  def parseRow(row, y) do
    row
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.filter(fn {cell, _x} -> cell != "." end)
    |> Enum.map(fn {cell, x} -> {{x, y}, String.to_atom(cell)} end)
  end
end
