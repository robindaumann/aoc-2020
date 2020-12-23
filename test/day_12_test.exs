defmodule Day12Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day12.part1(f) == 1106
  end

  test "part1 example" do
    f = Input.example()
    assert Day12.part1(f) == 25
  end

  test "part2 input" do
    f = Input.path()
    assert Day12.part2(f) == 107_281
  end

  test "part2 example" do
    f = Input.example()
    assert Day12.part2(f) == 286
  end
end
