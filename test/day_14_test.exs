defmodule Day14Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day14.part1(f) == 13_496_669_152_158
  end

  test "part1 example" do
    f = Input.example()
    assert Day14.part1(f) == 165
  end

  test "part2 input" do
    f = Input.path()
    assert Day14.part2(f) == 3_278_997_609_887
  end

  test "part2 example" do
    f = Input.path("_example2.txt")
    assert Day14.part2(f) == 208
  end

  test "test parse floating" do
    assert Day14.parse_floating("000000000000000000000000000000X1001X") == [0, 5]
  end

  test "floating bit combinations" do
    assert Day14.apply_floating_bits(0, [5]) == [0, 32]
  end

  test "floating bit combinations mult" do
    assert Day14.apply_floating_bits(0, [5, 3]) == [0, 32, 8, 40]
  end
end
