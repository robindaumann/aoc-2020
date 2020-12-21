defmodule Day09 do
  def part1(path, preamble_len) do
    path
    |> Input.read_numbers()
    |> Enum.split(preamble_len)
    |> find_invalid()
  end

  def part2(path, preamble_len) do
    input = Input.read_numbers(path)

    sum = Enum.split(input, preamble_len) |> find_invalid()

    input
    |> find_range(sum, 0, [])
    |> min_plus_max()
  end

  def find_range(_, sum, cur_sum, res) when cur_sum == sum do
    res
  end

  def find_range([n | ns], sum, cur_sum, res) when cur_sum < sum do
    find_range(ns, sum, cur_sum + n, res ++ [n])
  end

  def find_range(ns, sum, cur_sum, [r | res]) when cur_sum > sum do
    find_range(ns, sum, cur_sum - r, res)
  end

  def find_invalid({[_cur | curs] = buffer, [next | nexts]}) do
    if valid?(buffer, next) do
      find_invalid({curs ++ [next], nexts})
    else
      next
    end
  end

  def valid?([n | ns], sum) do
    rst = sum - n
    rst in ns || valid?(ns, sum)
  end

  def valid?([], _sum), do: false

  def min_plus_max(l) do
    Enum.min_max(l) |> Tuple.to_list() |> Enum.sum()
  end
end
