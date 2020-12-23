defmodule Day11Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day11.part1(f) == 2424
  end

  test "part1 example" do
    f = Input.example()
    assert Day11.part1(f) == 37
  end

  # test "part2 input" do
  #   f = Input.path()
  #   assert Day11.part2(f)
  # end

  # test "part2 example" do
  #   f = Input.example()
  #   assert Day11.part2(f)
  # end
end
