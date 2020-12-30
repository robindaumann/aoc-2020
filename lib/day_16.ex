defmodule Day16 do
  def part1(path) do
    {rules, tickets} = parse(path)

    tickets
    |> Enum.filter(&not_any_rule?(&1, rules))
    |> Enum.sum()
  end

  def part2(_path) do
    raise "not_implemented"
  end

  def parse(path) do
      path
      |> File.read!()
      |> String.split("\n\n")
      |> parse_parts()
  end

  def not_any_rule?(ticket, rules) do
    not Enum.any?(rules, &Enum.member?(&1, ticket))
  end

  def parse_parts([rules, _ticket, tickets]) do
    {parse_rules(rules), parse_tickets(tickets)}
  end

  defp parse_rules(rules) do
    Regex.scan(~r/(\d+)-(\d+)/, rules, capture: :all_but_first)
    |> Enum.map(&to_range/1)
  end

  defp to_range(bounds) do
    [from, to] = Enum.map(bounds, &String.to_integer/1)
    from..to
  end

  defp parse_tickets(tickets) do
    Regex.scan(~r/(\d+)/, tickets, capture: :all_but_first)
    |> Enum.map(fn [num] -> String.to_integer(num) end)
  end
end
