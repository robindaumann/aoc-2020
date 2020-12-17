defmodule Day08Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day08.part1(f) == 2080
  end

  test "part1 example" do
    f = Input.example()
    assert Day08.part1(f) == 5
  end

  test "part2 example" do
    f = Input.example()
    assert Day08.part2(f) == 8
  end

  test "part2 input" do
    f = Input.path()
    assert Day08.part2(f) == 2477
  end
end
