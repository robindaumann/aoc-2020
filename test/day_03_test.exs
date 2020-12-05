defmodule Day03Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 example" do
    f = Input.example()
    assert Day03.part1(f) == 7
  end

  test "part1 input" do
    f = Input.path()
    assert Day03.part1(f) == 209
  end

  test "part2 example" do
    f = Input.example()
    assert Day03.part2(f) == 336
  end

  test "part2 input" do
    f = Input.path()
    assert Day03.part2(f) == 1574890240
  end
end
