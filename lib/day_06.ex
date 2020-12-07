defmodule Day06 do
  def part1(path) do
    solve(path, &count_uniq_chars/1)
  end

  def part2(path) do
    solve(path, &count_intersecting_chars/1)
  end

  def solve(path, freq_map) do
    path
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(&to_frequencies/1)
    |> Enum.map(freq_map)
    |> Enum.sum()
  end

  def to_frequencies(group) do
    group
    |> String.trim_trailing()
    |> String.graphemes()
    |> Enum.frequencies()
    |> Map.pop("\n", 0)
  end

  def count_uniq_chars({_members, frequencies}), do: Enum.count(frequencies)

  def count_intersecting_chars({members, frequencies}) do
    Enum.filter(frequencies, fn {_char, count} -> count == members + 1 end)
    |> Enum.count()
  end
end
