defmodule Day02Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day02.part1(f) == 622
  end

  test "part2 input" do
    f = Input.path()
    assert Day02.part2(f) == 263
  end

  test "part1 example" do
    f = Input.example()
    assert Day02.part1(f) == 2
  end

  test "part2 example" do
    f = Input.example()
    assert Day02.part2(f) == 1
  end

  test "valid password 1 1" do
    assert Day02.contains_times?("abcd", "a", 1, 1)
  end

  test "valid password 1 4" do
    assert Day02.contains_times?("cccc", "c", 1, 4)
  end

  test "invalid password 2 4" do
    assert Day02.contains_times?("dasjndnjc", "c", 2, 4) == false
  end

  test "valid pass unicode" do
    assert Day02.contains_times?("got the €€€€", "€", 2, 4)
  end
end
