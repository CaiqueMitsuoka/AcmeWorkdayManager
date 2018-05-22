defmodule AcmeWorkdayManager.Models.Week do
  defstruct sun: 0, mon: 0, tue: 0, wed: 0, thu: 0, fri: 0, sat: 0

  def new do
    %AcmeWorkdayManager.Models.Week{}
  end

  def update_minutes(week, week_day, update_lambda) do
    day = String.to_existing_atom(week_day)

    Map.put(week, day, update_lambda.(Map.get(week, day)))
  end

  def get(week, day) when is_integer(day) do
    get(week, Enum.at([:sun, :mon, :tue, :wed, :thu, :fri, :sat], day - 1))
  end

  def get(week, day) do
    Map.get(week, day, 0)
  end
end
