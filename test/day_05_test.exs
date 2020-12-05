defmodule Day05Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day05.part1(f) == 813
  end

  test "part2 input" do
    f = Input.path()
    assert Day05.part2(f) == 612
  end
end
