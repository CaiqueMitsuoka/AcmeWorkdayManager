defmodule AcmeWorkdayManager.Timeclock do
  alias AcmeWorkdayManager.Models.Employee

  def add_entries_to(employees, file_path) do
    entries = open(file_path)

    Enum.map(employees, fn employee ->
      add_entries(employee, entries)
    end)
  end

  defp add_entries(employee, entries) do
    add_entry(employee, Enum.find(entries, &(&1.pis_number == employee.pis_number)))
  end

  defp add_entry(employee, nil) do
    employee
  end

  defp add_entry(employee, entry) do
    %Employee{employee | entries: parse_datetime(entry.entries)}
  end

  defp parse_datetime(datetimes) do
    Enum.map(datetimes, fn datetime ->
      DateTime.from_naive!(NaiveDateTime.from_iso8601!(datetime), "Etc/UTC")
    end)
  end

  defp open(file_path) do
    {:ok, config_json} = File.read(file_path)

    Poison.decode!(config_json, keys: :atoms)
  end
end
