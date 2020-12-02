defmodule Day01Test do
  use ExUnit.Case, async: true
  require Input

  test "day01 input" do
    f = Input.path()
    assert Day01.part1(f) == 440_979
  end

  test "day02 input" do
    f = Input.path()
    assert Day01.part2(f) == 82_498_112
  end

  test "day01 example" do
    f = Input.example()
    assert Day01.part1(f) == 514_579
  end

  test "day01 example part 2" do
    f = "input/day_01_example.txt"
    assert Day01.part2(f) == 241_861_950
  end

  test "binsearch even len" do
    ns = [1, 5, 7, 9]
    n = 9

    assert Day01.binsearch(ns, n) == 3
  end

  test "binsearch odd len" do
    ns = [7, 12, 13, 99, 100]
    n = 12

    assert Day01.binsearch(ns, n) == 1
  end

  test "binsearch not found" do
    ns = [7]
    n = 12

    assert Day01.binsearch(ns, n) == :not_found
  end
end
