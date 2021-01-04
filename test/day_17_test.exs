defmodule Day17Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day17.part1(f) == 284
  end

  test "part1 example" do
    f = Input.example()
    assert Day17.part1(f) == 112
  end

  @tag :simulation
  test "part2 input" do
    f = Input.path()
    assert Day17.part2(f) == 2240
  end

  @tag :simulation
  test "part2 example" do
    f = Input.example()
    assert Day17.part2(f) == 848
  end
end
