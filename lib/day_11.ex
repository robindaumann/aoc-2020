defmodule Day11 do
  def part1(path) do
    solve(path, &step/2)
  end

  def part2(path) do
    solve(path, &step_see/2)
  end

  def solve(path, step) do
    path
    |> Input.read_grid(fn cell -> cell != "." end)
    |> simulate(step)
    |> Enum.count(fn {_, seat} -> seat == :"#" end)
  end

  def simulate(%{grid: grid} = seats, step) do
    next = Enum.map(grid, fn seat -> step.(seats, seat) end) |> Map.new()

    if Map.equal?(grid, next) do
      next
    else
      simulate(%{seats | grid: next}, step)
    end
  end

  # part 1
  def step(%{grid: seats}, {pos, :L} = seat) do
    any_neighbour = Enum.any?(directions(), fn direction -> occupied?(seats, pos, direction) end)

    if any_neighbour do
      seat
    else
      {pos, :"#"}
    end
  end

  def step(%{grid: seats}, {pos, :"#"} = seat) do
    neighbours = Enum.count(directions(), fn direction -> occupied?(seats, pos, direction) end)

    if neighbours < 4 do
      seat
    else
      {pos, :L}
    end
  end

  # part 2
  def step_see(seats, {pos, :L} = seat) do
    any_neighbour =
      Enum.any?(directions(), fn direction -> see_occupied?(seats, pos, direction) end)

    if any_neighbour do
      seat
    else
      {pos, :"#"}
    end
  end

  def step_see(seats, {pos, :"#"} = seat) do
    neighbours =
      Enum.count(directions(), fn direction -> see_occupied?(seats, pos, direction) end)

    if neighbours < 5 do
      seat
    else
      {pos, :L}
    end
  end

  def directions() do
    for dx <- -1..1, dy <- -1..1, dx != 0 or dy != 0, do: {dx, dy}
  end

  def occupied?(seats, {x, y}, {dx, dy}) do
    Map.get(seats, {x + dx, y + dy}) == :"#"
  end

  def see_occupied?(
        %{grid: grid, width: width, height: height} = seats,
        {x, y},
        {dx, dy} = dir
      )
      when 0 <= x and x < width and 0 <= y and y < height do
    next_pos = {x + dx, y + dy}

    case Map.fetch(grid, next_pos) do
      {:ok, :"#"} -> true
      {:ok, :L} -> false
      :error -> see_occupied?(seats, next_pos, dir)
    end
  end

  def see_occupied?(_, _, _), do: false

  # defp show(seats) do
  #   {min_x, max_x} = Enum.map(seats, fn {{x, _y}, _} -> x end) |> Enum.min_max()
  #   {min_y, max_y} = Enum.map(seats, fn {{_x, y}, _} -> y end) |> Enum.min_max()

  #   Enum.each(min_y..max_y, fn y ->
  #     Enum.each(min_x..max_x, fn x ->
  #       IO.write(Map.get(seats, {x, y}, "."))
  #     end)

  #     IO.puts("")
  #   end)

  #   IO.puts("")
  #   seats
  # end
end
