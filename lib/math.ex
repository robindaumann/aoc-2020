defmodule Math do
  def product(elements) do
    Enum.reduce(elements, &*/2)
  end

  def sin_deg(angle) do
    to_rad(angle) |> :math.sin()
  end

  def cos_deg(angle) do
    to_rad(angle) |> :math.cos()
  end

  def to_rad(degrees) do
    :math.pi() * degrees / 180.0
  end

  def mod_inv(a, m) do
    case egcd(a, m) do
      {1, s, _t} -> rem(s + m, m)
      _ -> raise "#{a} and #{m} are not coprime!"
    end
  end

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
