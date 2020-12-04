defmodule Day04Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 example" do
    f = Input.example()
    assert Day04.part1(f) == 2
  end

  test "part1 input" do
    f = Input.path()
    assert Day04.part1(f) == 260
  end

  test "part2 input" do
    f = Input.path()
    assert Day04.part2(f) == 260
  end

  test "byr field" do
    assert Day04.field_valid?("byr:2002")
    assert Day04.field_valid?("byr:2003") == false
  end

  test "hgt field" do
    assert Day04.field_valid?("hgt:60in")
    assert Day04.field_valid?("hgt:190cm")
    assert Day04.field_valid?("hgt:190in") == false
    assert Day04.field_valid?("hgt:190") == false
  end

  test "hcl field" do
    assert Day04.field_valid?("hcl:#123abc")
    assert Day04.field_valid?("hcl:#123abz") == false
    assert Day04.field_valid?("hcl:123abc") == false
  end

  test "ecl field" do
    assert Day04.field_valid?("ecl:brn")
    assert Day04.field_valid?("ecl:wat") == false
  end

  test "pid field" do
    assert Day04.field_valid?("pid:000000001")
    assert Day04.field_valid?("pid:0123456789") == false
  end
end
