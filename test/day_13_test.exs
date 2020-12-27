defmodule Day13Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day13.part1(f) == 1915
  end

  test "part1 example" do
    f = Input.example()
    assert Day13.part1(f) == 295
  end

  test "part2 input" do
    f = Input.path()
    assert Day13.part2(f) == 294_354_277_694_107
  end

  test "part2 example" do
    f = Input.example()
    assert Day13.part2(f) == 1_068_781
  end

  test "wiki.org example" do
    assert Day13.chinese_remainder([{5, 4}, {7, 4}, {11, 6}]) == 39
  end

  test "brilliant.org example" do
    assert Day13.chinese_remainder([{3, 1}, {5, 4}, {7, 6}]) == 34
  end
end
