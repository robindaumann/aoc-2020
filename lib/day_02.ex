defmodule Day02 do
  def part1(path) do
    solve(path, &contains_times?/4)
  end

  def part2(path) do
    solve(path, &char_at?/4)
  end

  def solve(path, f) do
    path
    |> File.stream!()
    |> Enum.map(&Regex.run(~r/(\d+)-(\d+) (\w): (\w+)/, &1, capture: :all_but_first))
    |> Enum.filter(fn [min, max, char, password] ->
      f.(password, char, String.to_integer(min), String.to_integer(max))
    end)
    |> Enum.count()
  end

  def contains_times?(password, char, min, max) do
    count =
      password
      |> String.graphemes()
      |> Enum.count(fn e -> e == char end)

    count >= min and count <= max
  end

  def char_at?(password, char, pos1, pos2) do
    xor(String.at(password, pos1-1) == char, String.at(password, pos2-1) == char)
  end

  def xor(a, b) do
    (a or b) and not(a and b)
  end
end
