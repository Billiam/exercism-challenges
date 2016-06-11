require IEx;
defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @day_names ~w(monday tuesday wednesday thursday friday saturday sunday)a
  @schedule %{:teenth => 13, :first => 1, :second => 8, :third => 15, :fourth => 22}
  
  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth
  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    day = meetup_day(year, month, translate_weekday(weekday), schedule)
    
    {year, month, day}
  end

  defp meetup_day(year, month, weekday, :last) do
    last_of_month = :calendar.last_day_of_the_month(year, month)
    weekday_difference = weekday_of(year, month, last_of_month) - weekday  + 7 |> rem(7)
    
    last_of_month - weekday_difference
  end  
    
  defp meetup_day(year, month, weekday, schedule) do
    minimum_date = @schedule[schedule]

    weekday_difference = weekday - weekday_of(year, month, minimum_date) + 7 |> rem(7)
    
    minimum_date + weekday_difference
  end

  defp translate_weekday(day_name) do
    Enum.find_index(@day_names, &(&1 === day_name))
  end
  
  
  defp weekday_of(year, month, day) do
    :calendar.day_of_the_week(year, month, day) - 1
  end
end
