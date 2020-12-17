defmodule Day08 do
  def part1(path) do
    {acc, 1} =
      path
      |> init_mem()
      |> run()

    acc
  end

  def part2(path) do
    mem = init_mem(path)
    count = Enum.count(mem)

    mem = Map.put(mem, count, {:exit, 0})

    mem
    |> Enum.filter(fn {_key, {op, _arg}} -> op == :nop or op == :jmp end)
    |> Enum.find_value(fn instr ->
      case swap(mem, instr) |> run() do
        {acc, 0} -> acc
        {_, 1} -> false
      end
    end)
  end

  def init_mem(path) do
    path
    |> File.stream!()
    |> Enum.map(&parse/1)
    |> Enum.with_index()
    |> Enum.map(fn {e, idx} -> {idx, e} end)
    |> Map.new()
  end

  def parse(line) do
    [op, arg] = String.split(line)
    {String.to_atom(op), String.to_integer(arg)}
  end

  def swap(mem, {key, {op, arg}}) do
    swapped =
      case op do
        :nop -> :jmp
        :jmp -> :nop
      end

    Map.replace!(mem, key, {swapped, arg})
  end

  def run(mem) do
    pc = 0
    {next_instr, mem} = instr(mem, pc)
    execute(mem, next_instr, pc, 0)
  end

  def execute(mem, {:nop, _}, pc, acc) do
    next_pc = pc + 1
    {next_instr, mem} = instr(mem, next_pc)
    execute(mem, next_instr, next_pc, acc)
  end

  def execute(mem, {:acc, arg}, pc, acc) do
    acc = acc + arg
    next_pc = pc + 1
    {next_instr, mem} = instr(mem, next_pc)
    execute(mem, next_instr, next_pc, acc)
  end

  def execute(mem, {:jmp, arg}, pc, acc) do
    next_pc = pc + arg
    {next_instr, mem} = instr(mem, next_pc)
    execute(mem, next_instr, next_pc, acc)
  end

  def execute(_mem, {:exit, code}, _pc, acc) do
    {acc, code}
  end

  def instr(mem, pc) do
    Map.get_and_update!(mem, pc, fn current_value ->
      {current_value, {:exit, 1}}
    end)
  end
end
