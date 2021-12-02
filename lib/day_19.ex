defmodule Day19 do
  def part1(path) do
    parse_rules(path) |> count_matches()
  end

  def part2(path) do
    {rules, text} = parse_rules(path)
    rules = update_rules(rules)
    count_matches({rules, text})
  end

  def count_matches({rules, text}) do
    regex = Regex.compile!("^" <> build_regex(Map.fetch!(rules, "0"), rules) <> "$")

    text
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.filter(&Regex.match?(regex, &1))
    |> Enum.count()
  end

  def parse_rules(path) do
    [rules, ["\n"], text] = File.stream!(path) |> Enum.chunk_by(fn line -> line == "\n" end)

    rules =
      rules
      |> Enum.map(fn rule ->
        [idx, rule] = String.split(rule, ": ")
        {idx, parse_rule(rule)}
      end)
      |> Map.new()

    {rules, text}
  end

  # remove " and \n
  defp parse_rule("\"" <> rule), do: String.slice(rule, 0..-3)

  defp parse_rule(rule) do
    String.split(rule, " | ")
    |> Enum.map(&String.split/1)
  end

  def build_regex(rule, _) when is_binary(rule), do: rule

  def build_regex([refs], rules) do
    Enum.map_join(refs, fn ref ->
      Map.fetch!(rules, ref) |> build_regex(rules)
    end)
  end

  def build_regex([["42", "31"], ["42", "11", "31"]], rules) do
    reg_42 = build_regex([["42"]], rules)
    reg_31 = build_regex([["31"]], rules)

    "((#{reg_42})(?1)?(#{reg_31}))"
  end

  def build_regex([["42"], ["42", "8"]], rules) do
    reg_42 = build_regex([["42"]], rules)

    "(#{reg_42})+"
  end

  def build_regex([a, b], rules) do
    a_reg = build_regex([a], rules)
    b_reg = build_regex([b], rules)

    "(#{a_reg}|#{b_reg})"
  end

  def update_rules(rules) do
    rules
    |> Map.put("8", [["42"], ["42", "8"]])
    |> Map.put("11", [["42", "31"], ["42", "11", "31"]])
  end
end
