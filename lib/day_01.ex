defmodule Day01 do
  def part1(path) do
    path
    |> parse
    |> findProduct(2020)
  end

  def part2(path) do
    path
    |> parse
    |> findProductTriple(2020)
  end

  def parse(path) do
    path
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
  end

  def findProductTriple([n | ns], sum) do
    m = sum - n

    case findProduct(ns, m) do
      :not_found -> findProductTriple(ns, sum)
      prod -> prod * n
    end
  end

  def findProductTriple([], _) do
    :not_found
  end

  def findProduct([n | ns], sum) do
    m = sum - n

    case binsearch(ns, m) do
      :not_found -> findProduct(ns, sum)
      _ -> n * m
    end
  end

  def findProduct([], _) do
    :not_found
  end

  def binsearch(ns, x) do
    binsearch(ns, x, 0, Enum.count(ns) - 1)
  end

  def binsearch(ns, x, l, r) when l <= r do
    mid = div(l + r, 2)
    n = Enum.at(ns, mid)

    cond do
      x == n ->
        mid

      x > n ->
        binsearch(ns, x, mid + 1, r)

      x < n ->
        binsearch(ns, x, l, mid - 1)
    end
  end

  def binsearch(_, _, _, _) do
    :not_found
  end
end
