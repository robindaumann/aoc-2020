defmodule Math do
  @spec pow(integer, integer) :: integer
  def pow(x, n) do
    trunc(:math.pow(x, n))
  end

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

  @spec mod_inv(number, integer) :: integer
  def mod_inv(a, m) do
    case egcd(a, m) do
      {1, s, _t} -> rem(s + m, m)
      _ -> raise "#{a} and #{m} are not coprime!"
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
