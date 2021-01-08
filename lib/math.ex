defmodule Math do
  @doc """
  Calculates the cartesian product of the given enumerables.

  ## Options

    * `:repeat` - when given repeats the the enum the given times

  ## Examples

    iex> Math.cartesian([[:a, :b], [:c]])
    [[:a, :c], [:b, :c]]

    iex> Math.cartesian([0..1], repeat: 2)
    [[0, 0], [1, 0], [0, 1], [1, 1]]

  """
  @spec cartesian([Enumerable.t()], [term()]) :: list()
  def cartesian(enums, opts \\ [])
  def cartesian([], _opts), do: []

  def cartesian(enums, opts) when is_list(opts) do
    repeat = Keyword.get(opts, :repeat, 1)

    enums
    |> Enum.reverse()
    |> duplicate_flat(repeat)
    |> _cartesian([])
  end

  defp _cartesian([], elems), do: [elems]

  defp _cartesian([h | tail], elems) do
    Enum.flat_map(h, fn x -> _cartesian(tail, [x | elems]) end)
  end

  defp duplicate_flat(list, count) do
    Stream.cycle(list) |> Enum.take(length(list) * count)
  end

  @doc """
  Calculates x to the nth power and trucates to integer

  ## Examples

    iex> Math.pow(2, 5)
    32

  """
  @spec pow(integer, integer) :: integer
  def pow(x, n) when is_integer(x) and is_integer(n) do
    trunc(:math.pow(x, n))
  end

  def pow(x, n) do
    raise ArithmeticError, message: "pow currently supports integers only got: x=#{x}, n=#{n}"
  end

  @doc """
  Calculates the product of the given numbers

  ## Examples

    iex> Math.product([1, 2, 3])
    6

    iex> Math.product([5, -6])
    -30

  """
  @spec product([number]) :: number
  def product(elements) do
    Enum.reduce(elements, &*/2)
  end

  @doc """
  Calculates the sine at the given point.

  Expects the argument to be an angle in degrees.

    ## Examples
    iex>Math.sin_deg(0)
    0.0

    iex>Math.sin_deg(90)
    1.0

    iex>Math.sin_deg(180)
    0.0

    iex>Math.sin_deg(270)
    -1.0

    iex>Math.sin_deg(360)
    0.0

  """
  @spec sin_deg(number) :: float
  def sin_deg(angle) do
    to_rad(angle) |> :math.sin() |> Float.round(15)
  end

  @doc """
  Calculates the cosine function at the given point.

  Expects the argument to be an angle in degrees.

  ## Examples
    iex>Math.cos_deg(0)
    1.0

    iex>Math.cos_deg(90)
    0.0

    iex>Math.cos_deg(180)
    -1.0

    iex>Math.cos_deg(270)
    0.0

    iex>Math.cos_deg(360)
    1.0

  """
  @spec cos_deg(number) :: float
  def cos_deg(angle) do
    to_rad(angle) |> :math.cos() |> Float.round(15)
  end

  @spec to_rad(number) :: float
  def to_rad(degrees) do
    :math.pi() * degrees / 180.0
  end

  @doc """
  Calculates the [modular multiplicative inverse](https://en.wikipedia.org/wiki/Modular_multiplicative_inverse).

  Expects the arguments to be coprime.

  ## Examples
    iex>Math.mod_inv(3, 5)
    2

    iex>Math.mod_inv(13, 7)
    6

  """
  @spec mod_inv(number, integer) :: integer
  def mod_inv(a, m) do
    case egcd(a, m) do
      {1, s, _t} -> rem(s + m, m)
      _ -> raise ArithmeticError, message: "#{a} and #{m} are not coprime!"
    end
  end

  @spec egcd(number, number) :: {number, integer, integer}
  def egcd(a, b) do
    _egcd(abs(a), abs(b), 0, 1, 1, 0)
  end

  defp _egcd(0, b, s, t, _u, _v) do
    {b, s, t}
  end

  defp _egcd(a, b, s, t, u, v) do
    q = div(b, a)
    r = rem(b, a)

    m = s - u * q
    n = t - v * q

    _egcd(r, a, u, v, m, n)
  end
end
