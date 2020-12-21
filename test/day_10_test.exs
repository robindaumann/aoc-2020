defmodule Day10Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day10.part1(f) == 2400
  end

  test "part1 example" do
    f = Input.example()
    assert Day10.part1(f) == 35
  end

  test "part1 example2" do
    f = Input.path("_example2.txt")
    assert Day10.part1(f) == 220
  end

  test "part2 input" do
    f = Input.path()
    assert Day10.part2(f) == 338_510_590_509_056
  end

  test "part2 example" do
    f = Input.example()
    assert Day10.part2(f) == 8
  end

  test "part2 example2" do
    f = Input.path("_example2.txt")
    assert Day10.part2(f) == 19208
  end
end
