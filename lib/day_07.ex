defmodule Day07 do
  def part1(path) do
    path
    |> to_graph()
    |> count_reachable("shiny gold")
  end

  def part2(path) do
    g = to_graph(path)

    dfs(g, :digraph.out_edges(g, "shiny gold"))
  end

  def dfs(_g, []), do: 0

  def dfs(g, edges) do
    edges
    |> Enum.map(fn edge ->
      {^edge, _current, next, amount} = :digraph.edge(g, edge)
      amount + amount * dfs(g, :digraph.out_edges(g, next))
    end)
    |> Enum.sum()
  end

  def to_graph(path) do
    path
    |> File.stream!()
    |> Enum.map(&Regex.scan(~r/(?:(\d+) )?(\w+ \w+) bags?/, &1, capture: :all_but_first))
    |> Enum.reduce(:digraph.new(), &add_edges/2)
  end

  def count_reachable(g, target) do
    :digraph_utils.reaching_neighbours([target], g) |> Enum.count()
  end

  def add_edges([_from, ["", "no other"]], g) do
    g
  end

  def add_edges([["", from] | tos], g) do
    ^from = :digraph.add_vertex(g, from)
    Enum.reduce(tos, g, fn [weight, to], g -> add_edge(from, to, weight, g) end)
  end

  def add_edge(from, to, weight, g) do
    ^to = :digraph.add_vertex(g, to)
    [:"$e" | _] = :digraph.add_edge(g, from, to, String.to_integer(weight))
    g
  end
end
