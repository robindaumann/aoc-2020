defmodule Day05 do
  def part1(path) do
    path
    |> parse()
    |> Enum.max()
  end

  def part2(path) do
    uids = MapSet.new(parse(path))

    {min, max} = Enum.min_max(uids)

    [seat_id] = MapSet.difference(MapSet.new(min..max), uids) |> Enum.to_list()
    # |> Enum.filter(fn e -> MapSet.member?(uids, e+1) and MapSet.member?(uids, e-1) end)

    seat_id
  end

  def parse(path) do
    path
    |> File.stream!()
    |> Enum.map(&uid/1)
  end

  def uid(boarding_pass) do
    {number, "\n"} =
      boarding_pass
      |> String.replace(["B", "R"], "1")
      |> String.replace(["F", "L"], "0")
      |> Integer.parse(2)

    number
  end
end
