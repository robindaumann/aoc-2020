defmodule Day04 do
  def part1(path) do
    solve(path, &valid?/1)
  end

  def part2(path) do
    solve(path, fn passport -> valid?(passport) and valid_strict?(passport) end)
  end

  def solve(path, f) do
    path
    |> File.stream!()
    |> Enum.chunk_by(fn line -> line == "\n" end)
    |> Enum.map(&Enum.join/1)
    |> Enum.count(f)
  end

  def valid?(passport) do
    Enum.all?(~w(byr: iyr: eyr: hgt: hcl: ecl: pid:), &String.contains?(passport, &1))
  end

  def valid_strict?(passport) do
    String.split(passport) |> Enum.all?(&field_valid?/1)
  end

  def field_valid?("byr:" <> year), do: between?(year, 1920, 2002)

  def field_valid?("iyr:" <> year), do: between?(year, 2010, 2020)

  def field_valid?("eyr:" <> year), do: between?(year, 2020, 2030)

  def field_valid?("hgt:" <> height) do
    with {height, unit} <- String.split_at(height, -2),
         {height, ""} <- Integer.parse(height) do
      (unit == "cm" and 150 <= height and height <= 193) or
        (unit == "in" and 59 <= height and height <= 76)
    else
      _ -> false
    end
  end

  def field_valid?("hcl:#" <> color), do: Regex.match?(~r/^[0-9a-f]{6}$/, color)

  def field_valid?("ecl:" <> color) do
    Enum.member?(~w(amb blu brn gry grn hzl oth), color)
  end

  def field_valid?("pid:" <> id), do: Regex.match?(~r/^\d{9}$/, id)

  def field_valid?("cid:" <> _), do: true

  def field_valid?(_), do: false

  def between?(year, min, max) do
    with {year, ""} <- Integer.parse(year) do
      min <= year and year <= max
    else
      _ ->
        false
    end
  end
end
