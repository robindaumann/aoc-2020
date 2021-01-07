defmodule Day18 do
  @number_reg ~r/^(\d+)$/

  def part1(path) do
    path
    |> File.stream!()
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&eval_ltr/1)
    |> Enum.sum()
  end

  def eval_ltr(expr) do
    expr
    |> reverse()
    |> eval()
  end

  def reverse(""), do: ""
  def reverse(" " <> rst), do: reverse(rst)
  def reverse("(" <> rst), do: reverse(rst) <> ")"
  def reverse(")" <> rst), do: reverse(rst) <> "("
  def reverse(<<head::utf8, rst::binary>>), do: reverse(rst) <> <<head>>

  def eval("(" <> expr) do
    pos = find_closing(expr, 1)
    {lhs, rhs} = String.split_at(expr, pos)
    bracket_expr = String.slice(lhs, 0..-2)

    if rhs == "" do
      eval(bracket_expr)
    else
      {"", op, rhs} = parse_op(rhs)
      apply(Kernel, op, [eval(bracket_expr), eval(rhs)])
    end
  end

  def eval(expr) do
    if Regex.match?(@number_reg, expr) do
      parse_number(expr)
    else
      {lhs, op, rhs} = parse_op(expr)
      apply(Kernel, op, [eval(lhs), eval(rhs)])
    end
  end

  defp parse_number(expr) do
    String.reverse(expr) |> String.to_integer()
  end

  defp parse_op(expr) do
    [lhs, op, rhs] = Regex.split(~r/([+*])/, expr, parts: 2, include_captures: true)
    {lhs, String.to_atom(op), rhs}
  end

  defp find_closing(")" <> _, depth) when depth == 1, do: 1

  defp find_closing(")" <> expr, depth) do
    find_closing(expr, depth - 1) + 1
  end

  defp find_closing("(" <> expr, depth) do
    find_closing(expr, depth + 1) + 1
  end

  defp find_closing(<<_next::utf8, rst::binary>>, depth) do
    find_closing(rst, depth) + 1
  end
end
