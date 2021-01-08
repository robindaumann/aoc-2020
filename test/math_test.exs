defmodule MathTest do
  use ExUnit.Case, async: true
  doctest Math

  test "pow float raises" do
    assert_raise ArithmeticError, fn -> Math.pow(2.5, 3) end
  end

  test "mod inv not coprime raises" do
    assert_raise ArithmeticError, fn -> Math.mod_inv(2, 4) end
  end

  test "product empty" do
    assert_raise Enum.EmptyError, fn -> Math.product([]) end
  end
end
