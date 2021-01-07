defmodule Day18Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day18.part1(f) == 50956598240016
  end

  test "prepare" do
    assert Day18.reverse(" (3 * 1) ") == "(1*3)"
  end

  test "eval simple" do
    assert Day18.eval_ltr("1 + 2 * 3 + 4 * 5 + 6") == 71
  end

  test "eval bracket" do
    assert Day18.eval_ltr("2 * 3 + (4 * 5)") == 26
  end

  test "eval bracket nested" do
    assert Day18.eval_ltr("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") == 12240
  end
end
