defmodule Day07Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day07.part1(f) == 172
  end

  test "part1 example" do
    f = Input.example()
    assert Day07.part1(f) == 4
  end

  test "part2 input" do
    f = Input.path()
    assert Day07.part2(f) == 39645
  end

  test "part2 example" do
    f = Input.example()
    assert Day07.part2(f) == 32
  end

  test "part2 example2" do
    f = Input.path("_example2.txt")
    assert Day07.part2(f) == 126
  end
end
