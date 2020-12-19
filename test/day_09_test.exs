defmodule Day09Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day09.part1(f, 25) == 776_203_571
  end

  test "part1 example" do
    f = Input.example()
    assert Day09.part1(f, 5) == 127
  end

  test "part2 input" do
    f = Input.path()
    assert Day09.part2(f, 25) == 104_800_569
  end

  test "part2 example" do
    f = Input.example()
    assert Day09.part2(f, 5) == 62
  end

  test "valid" do
    assert Day09.valid?([1, 2, 3], 4)
  end

  test "invalid" do
    assert Day09.valid?([1, 2, 3], 7) == false
  end
end
