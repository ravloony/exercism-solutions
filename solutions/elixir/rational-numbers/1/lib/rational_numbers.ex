defmodule RationalNumbers do
  import Kernel, except: [abs: 1]

  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    RationalNumbers.reduce({(a1 * b2 + a2 * b1), (b1 * b2)})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
     RationalNumbers.reduce({(a1 * b2 - a2 * b1), (b1 * b2)})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    RationalNumbers.reduce({(a1 * a2), (b1 * b2)})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) do
    RationalNumbers.reduce({(a1 * b2), (b1 * a2)})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(x :: rational) :: rational
  def abs({a, b}) do
    {Kernel.abs(a), Kernel.abs(b)}
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a1, b1}, n) when n >= 0 do
    RationalNumbers.reduce({Integer.pow(a1,n), Integer.pow(b1,n)})
  end
  def pow_rational({a1, b1}, n) when n < 0 do
    RationalNumbers.reduce({Integer.pow(b1,abs(n)), Integer.pow(a1,abs(n))})
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    RationalNumbers.nth_root(b + 0.0, Float.pow(x + 0.0, a))
  end

  def nth_root(n, x, precision\\1.0e-5) do
    f = fn(prev) -> ((n - 1) * prev + x/ Float.pow(prev, (n-1)))/n end
    fixed_point(f, x, precision, f.(x))
  end
 
  defp fixed_point(_, guess, tolerance, next) when Kernel.abs(guess - next) < tolerance, do: next
  defp fixed_point(f, _, tolerance, next), do: fixed_point(f, next, tolerance, f.(next))

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({num, den}) when den >= 0, do: reduce_({num, den})
  def reduce({num, den}) when den < 0, do: reduce_({-num, -den})

  def reduce_({num, den}) do
     g = Integer.gcd(num, den)
    {(num/g), (den/g)}
  end
end
