defmodule AcmeWorkdayManager.Service.Entries do
  alias AcmeWorkdayManager.Models.Employee

  def get_work_report(employee) do
    %Employee{
      employee
      | report:
          employee.entries
          |> split_entries_by_day
          |> sort_entries
          |> Enum.reduce(%{}, &calculate_workday_in_minutes/2)
          |> Enum.reduce(%{}, &calculate_rest_in_minutes/2)
    }
  end

  defp split_entries_by_day(entries) do
    Enum.reduce(entries, %{}, fn entry, splited_entries ->
      Map.update(
        splited_entries,
        DateTime.to_date(entry),
        %{entries: [entry]},
        &%{entries: List.insert_at(Map.get(&1, :entries), -1, entry)}
      )
    end)
  end

  defp sort_entries(reports) do
    Enum.reduce(reports, %{}, fn {date, report}, sorted_entries ->
      Map.put(sorted_entries, date, %{
        entries: Enum.sort(report.entries, &(DateTime.diff(&1, &2) < 0))
      })
    end)
  end

  defp calculate_workday_in_minutes({date, report}, reports) do
    [head | tail] = report.entries

    new_report = Map.put(report, :total_worked_minutes, sum_minutes(head, tail, 0, true))

    Map.put(reports, date, new_report)
  end

  defp calculate_rest_in_minutes({date, report}, reports) do
    [head | tail] = report.entries

    new_report = Map.put(report, :total_rested_minutes, sum_minutes(head, tail, 0, false))

    Map.put(reports, date, new_report)
  end

  defp sum_minutes(_, [], minutes, _) do
    minutes
  end

  defp sum_minutes(last_entry, entries, minutes, true) do
    [current_entry | tail] = entries
    sum_minutes = DateTime.diff(current_entry, last_entry) / 60 + minutes
    sum_minutes(current_entry, tail, sum_minutes, false)
  end

  defp sum_minutes(_, entries, minutes, false) do
    [current_entry | tail] = entries
    sum_minutes(current_entry, tail, minutes, true)
  end
end
