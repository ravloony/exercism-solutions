defmodule LibraryFees do
  def datetime_from_string(string) do
    case NaiveDateTime.from_iso8601(string) do
      {:ok, ndt} -> ndt
      _ -> nil
    end
  end

  def before_noon?(datetime) do
    case Time.compare(~T[12:00:00], NaiveDateTime.to_time(datetime)) do
      :gt -> true
      :lt -> false
      :eq -> false
    end
  end

  def return_date(checkout_datetime) do
    to_add = if before_noon?(checkout_datetime), do: 28, else: 29
    NaiveDateTime.to_date(checkout_datetime)
      |> Date.add(to_add)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    diff = NaiveDateTime.to_date(actual_return_datetime) |> Date.diff(planned_return_date)
    cond do
      diff >= 0 -> diff
      true -> 0
    end
  end

  def monday?(datetime) do
    datetime
      |> NaiveDateTime.to_date()
      |> Date.day_of_week()
      |> then(fn d -> d == 1 end)
  end

  def calculate_late_fee(checkout, return, rate) do
    ret = datetime_from_string(return)
    checkout
      |> datetime_from_string()
      |> return_date()
      |> days_late(ret)
      |> then(fn days -> (if monday?(ret), do: 0.5, else: 1) * rate * days end)
      |> floor()
  end
end
