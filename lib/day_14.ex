defmodule Day14 do
  import Bitwise
  require Logger

  def part1(path) do
    or_mask = 0
    and_mask = ~~~or_mask

    masks = {and_mask, or_mask}
    solve(path, &exec/2, masks)
  end

  def part2(path) do
    or_mask = 0
    floating_bits = []
    solve(path, &exec_v2/2, {or_mask, floating_bits})
  end

  def solve(path, exec, masks) do
    path
    |> File.stream!()
    |> Enum.reduce(%{mem: %{}, masks: masks}, exec)
    |> Map.fetch!(:mem)
    |> Map.values()
    |> Enum.sum()
  end

  def exec("mask = " <> mask, state) do
    mask = String.trim_trailing(mask)
    or_mask = parse_mask(mask, "0")
    and_mask = parse_mask(mask, "1")

    %{state | masks: {and_mask, or_mask}}
  end

  def exec("mem" <> command, %{mem: mem, masks: {and_mask, or_mask}} = state) do
    [addr, value] = parse_command(command)

    masked = value |> band(and_mask) |> bor(or_mask)
    mem = Map.put(mem, addr, masked)

    %{state | mem: mem}
  end

  def exec_v2("mask = " <> mask, state) do
    mask = String.trim_trailing(mask)
    or_mask = parse_mask(mask, "0")
    floating_bits = parse_floating(mask)

    Logger.debug(
      "or_mask:#{Integer.to_string(or_mask, 2)}, floating_bits:#{inspect(floating_bits)}"
    )

    %{state | masks: {or_mask, floating_bits}}
  end

  def exec_v2("mem" <> command, %{mem: mem, masks: {or_mask, floating_bits}} = state) do
    [addr, value] = parse_command(command)

    masked = addr ||| or_mask

    mem =
      apply_floating_bits(masked, floating_bits)
      |> Enum.reduce(mem, fn addr, mem ->
        Logger.debug("mem[#{addr}] = #{value}")
        Map.put(mem, addr, value)
      end)

    %{state | mem: mem}
  end

  defp parse_command(command) do
    Regex.run(~r/^\[(\d+)\] = (\d+)$/, command, capture: :all_but_first)
    |> Enum.map(&String.to_integer/1)
  end

  defp parse_mask(mask, x_replacement) do
    String.replace(mask, "X", x_replacement) |> String.to_integer(2)
  end

  def parse_floating(mask) do
    String.graphemes(mask)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.flat_map(fn {bit, idx} -> if bit == "X", do: [idx], else: [] end)
  end

  def apply_floating_bits(num, floating_bits) do
    combinations = Math.pow(2, Enum.count(floating_bits))

    Enum.map(0..(combinations - 1), &set_bits(&1, floating_bits, num))
  end

  def set_bits(bits, positions, number) do
    bits
    |> Integer.digits(2)
    |> Enum.reverse()
    |> Stream.concat(Stream.cycle([0]))
    |> Enum.zip(positions)
    |> Enum.reduce(number, &set_bit/2)
  end

  def set_bit({0, pos}, n) do
    n &&& ~~~(1 <<< pos)
  end

  def set_bit({1, pos}, n) do
    n ||| 1 <<< pos
  end
end
