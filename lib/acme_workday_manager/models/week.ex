defmodule AcmeWorkdayManager.Models.Week do
  defstruct sun: 0, mon: 0, tue: 0, wed: 0, thu: 0, fri: 0, sat: 0

  def new do
    %AcmeWorkdayManager.Models.Week{}
  end

  def update_minutes(week, week_day, update_lambda) do
    day = String.to_existing_atom(week_day)

    Map.put(week, day, update_lambda.(Map.get(week, day)))
  end
end
