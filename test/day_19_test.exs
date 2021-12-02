defmodule Day19Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day19.part1(f) == 136
  end

  test "part1 example" do
    f = Input.example()
    assert Day19.part1(f) == 2
  end

  test "part2 example no change" do
    f = Input.example(2)
    assert Day19.part1(f) == 3
  end

  test "part2 example loop" do
    f = Input.example(2)
    assert Day19.part2(f) == 12
  end

  test "part2 input" do
    f = Input.path()
    assert Day19.part2(f) == 12
  end
end
