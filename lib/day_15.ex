defmodule Day15 do
  def part1(path) do
    solve(path, 2020)
  end

  def part2(path) do
    solve(path, 30_000_000)
  end

  def solve(path, turns) do
    {spoken, number, turn} = parse(path)

    (turn + 1)..turns
    |> Enum.reduce({number, spoken}, &turn/2)
    |> elem(0)
  end

  def turn(turn, {number, spoken}) do
    last_turn = turn - 1

    Map.get_and_update(spoken, number, fn last_spoken ->
      say = if last_spoken == nil, do: 0, else: last_turn - last_spoken
      {say, last_turn}
    end)
  end

  defp parse(path) do
    path
    |> File.read!()
    |> String.trim_trailing()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index(1)
    |> get_map_pop_last()
  end

  defp get_map_pop_last(spoken) do
    {{number, turn}, spoken} = List.pop_at(spoken, -1)
    {Map.new(spoken), number, turn}
  end
end
