defmodule Day15Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day15.part1(f) == 211
  end

  test "part1 example" do
    f = Input.example()
    assert Day15.part1(f) == 436
  end

  @tag :simulation
  test "part2 input" do
    f = Input.path()
    assert Day15.part2(f) == 0
  end

  @tag :simulation
  test "part2 example" do
    f = Input.example()
    assert Day15.part2(f) == 175594
  end
end
