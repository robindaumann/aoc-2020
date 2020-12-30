defmodule Day16Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day16.part1(f) == 20013
  end

  test "part1 example" do
    f = Input.example()
    assert Day16.part1(f) == 71
  end
end
