defmodule Day13 do
  def part1(path) do
    {time, busses} = parse(path)

    busses
    |> Enum.map(fn {bus, _idx} -> [bus, bus - rem(time, bus)] end)
    |> Enum.min_by(fn [_bus, diff] -> diff end)
    |> Math.product()
  end

  def part2(path) do
    path
    |> parse()
    |> elem(1)
    |> Enum.map(fn {n, a} -> if a == 0, do: {n, a}, else: {n, n - a} end)
    |> chinese_remainder()
  end

  def chinese_remainder(contraints) do
    prod = Enum.map(contraints, fn {n, _a} -> n end) |> Math.product()

    # Variable naming see https://brilliant.org/wiki/chinese-remainder-theorem/
    contraints
    |> Enum.map(fn {n, a} ->
      y = div(prod, n)
      z = Math.mod_inv(y, n)
      a * y * z
    end)
    |> Enum.sum()
    |> rem(prod)
  end

  def parse(path) do
    [time, busses] = File.read!(path) |> String.split()

    busses =
      busses
      |> String.split(",")
      |> Enum.with_index()
      |> Enum.filter(fn {bus, _idx} -> bus != "x" end)
      |> Enum.map(fn {bus, idx} -> {String.to_integer(bus), idx} end)

    {String.to_integer(time), busses}
  end
end
