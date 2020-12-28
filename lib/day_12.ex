defmodule Day12 do
  def part1(path) do
    solve(path, &move/2, {1, 0})
  end

  def part2(path) do
    solve(path, &move_waypoint/2, {10, 1})
  end

  def solve(path, move, start) do
    path
    |> File.stream!()
    |> Enum.map(&parse/1)
    |> Enum.reduce({{0, 0}, start}, move)
    |> elem(0)
    |> manhattan({0, 0})
  end

  def parse(line) do
    {op, arg} =
      line
      |> String.trim_trailing()
      |> String.split_at(1)

    {op, String.to_integer(arg)}
  end

  # part 1
  def move({"N", amount}, {pos, direction}), do: {add(pos, {0, amount}), direction}

  def move({"S", amount}, {pos, direction}), do: {add(pos, {0, -amount}), direction}

  def move({"E", amount}, {pos, direction}), do: {add(pos, {amount, 0}), direction}

  def move({"W", amount}, {pos, direction}), do: {add(pos, {-amount, 0}), direction}

  def move({"L", angle}, {pos, direction}), do: {pos, rotate(direction, angle)}

  def move({"R", angle}, {pos, direction}), do: {pos, rotate(direction, -angle)}

  def move({"F", scalar}, {pos, direction}), do: {add(pos, direction, scalar), direction}
  # part 2
  def move_waypoint({"N", amount}, {pos, waypoint}), do: {pos, add(waypoint, {0, amount})}

  def move_waypoint({"S", amount}, {pos, waypoint}), do: {pos, add(waypoint, {0, -amount})}

  def move_waypoint({"E", amount}, {pos, waypoint}), do: {pos, add(waypoint, {amount, 0})}

  def move_waypoint({"W", amount}, {pos, waypoint}), do: {pos, add(waypoint, {-amount, 0})}

  def move_waypoint({"L", angle}, {pos, waypoint}), do: {pos, rotate(waypoint, angle)}

  def move_waypoint({"R", angle}, {pos, waypoint}), do: {pos, rotate(waypoint, -angle)}

  def move_waypoint({"F", scalar}, {pos, waypoint}), do: {add(pos, waypoint, scalar), waypoint}

  defp add({x1, y1}, {x2, y2}, scalar \\ 1), do: {x1 + scalar * x2, y1 + scalar * y2}

  defp manhattan({x, y}, {x0, y0}), do: abs(x - x0) + abs(y - y0)

  defp rotate({x, y}, angle) do
    sin = Math.sin_deg(angle)
    cos = Math.cos_deg(angle)
    {x * cos - y * sin, x * sin + y * cos}
  end
end
