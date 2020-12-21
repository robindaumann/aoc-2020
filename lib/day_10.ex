defmodule Day10 do
  def part1(path) do
    path
    |> parse()
    |> frequencies(%{1 => 0, 3 => 0})
  end

  def part2(path) do
    path
    |> parse()
    |> Enum.reduce(%{1 => 0, 2 => 0, 3 => 1, :prev => 0}, &traverse/2)
    |> Map.fetch!(3)
  end

  def parse(path) do
    path
    |> Input.read_numbers()
    |> add_start_end()
    |> Enum.sort()
  end

  def add_start_end(adapters), do: adapters ++ [0, Enum.max(adapters) + 3]

  def frequencies(nodes, %{1 => ones, 3 => threes}) when length(nodes) < 2 do
    ones * threes
  end

  def frequencies([from | rest], freq) do
    diff = hd(rest) - from
    frequencies(rest, Map.update!(freq, diff, &(&1 + 1)))
  end

  def traverse(adapter, %{:prev => prev} = counts) when adapter - prev == 0 do
    %{counts | prev: prev}
  end

  def traverse(adapter, %{1 => one, 2 => two, 3 => three, :prev => prev})
      when adapter - prev == 1 do
    %{1 => two, 2 => three, 3 => one + two + three, :prev => adapter}
  end

  def traverse(adapter, %{2 => two, 3 => three, :prev => prev}) when adapter - prev == 2 do
    %{1 => three, 2 => 0, 3 => two + three, :prev => adapter}
  end

  def traverse(adapter, %{3 => three, :prev => prev}) when adapter - prev == 3 do
    %{1 => 0, 2 => 0, 3 => three, :prev => adapter}
  end
end
