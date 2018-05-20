defmodule AcmeWorkdayManager.Models.Employee do
  alias __MODULE__
  alias AcmeWorkdayManager.Models.Week

  defstruct name: nil, pis_number: nil, week_workload: %Week{}, week_rest: %Week{}, entries: []

  def new(collection) when is_list(collection) do
    Enum.map(collection, &new(&1))
  end

  def new(%{name: name, pis_number: pis_number, workload: workload}) do
    %Employee{
      name: name,
      pis_number: pis_number,
      week_workload: parse_workload(workload),
      week_rest: parse_rest(workload)
    }
  end

  def find_by_pis_number(employee_enum, pis_number) do
    Enum.find(employee_enum, &(&1.pis_number == pis_number))
  end

  defp parse_workload(workloads) do
    parse_week(workloads, :workload_in_minutes)
  end

  defp parse_rest(workloads) do
    parse_week(workloads, :minimum_rest_interval_in_minutes)
  end

  defp parse_week(workloads, attr) do
    week = Week.new()

    Enum.reduce(workloads, week, fn workload, week ->
      Enum.reduce(workload.days, week, fn day, week ->
        Week.update_minutes(week, day, &(&1 + Map.get(workload, attr)))
      end)
    end)
  end
end
