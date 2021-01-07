defmodule InputTest do
  use ExUnit.Case, async: true
  require Input

  test "read numbers" do
    expect = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
    assert Input.read_numbers("input/day_10_example.txt") == expect
  end

  test "read grid" do
    %{grid: grid, height: height, width: width} = Input.read_grid("input/day_17_example.txt")

    expect = %{
      {0, 0} => :.,
      {0, 1} => :.,
      {0, 2} => :"#",
      {1, 0} => :"#",
      {1, 1} => :.,
      {1, 2} => :"#",
      {2, 0} => :.,
      {2, 1} => :"#",
      {2, 2} => :"#"
    }

    assert height == 3
    assert width == 3
    assert grid == expect
  end

  test "read grid filter" do
    %{grid: grid, height: height, width: width} =
      Input.read_grid("input/day_17_example.txt", &(&1 == "."))

    expect = %{
      {0, 0} => :.,
      {0, 1} => :.,
      {1, 1} => :.,
      {2, 0} => :.
    }

    assert height == 3
    assert width == 3
    assert grid == expect
  end
end
