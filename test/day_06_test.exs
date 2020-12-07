defmodule Day06Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day06.part1(f) == 6714
  end

  test "part1 example" do
    f = Input.example()
    assert Day06.part1(f) == 11
  end

  test "part2 input" do
    f = Input.path()
    assert Day06.part2(f) == 3435
  end

  test "part2 example" do
    f = Input.example()
    assert Day06.part2(f) == 6
  end
end
