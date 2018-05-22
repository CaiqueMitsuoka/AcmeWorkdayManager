defmodule AcmeWorkdayManager.EmployeeSerializer do
  alias __MODULE__

  defstruct pis_number: "", summary: %{balance: ""}, history: []

  def new(employees, start_date, end_date) when is_list(employees) do
    Enum.map(employees, &new(&1, start_date, end_date))
  end

  def new(employee, start_date, end_date) do
    %EmployeeSerializer{
      pis_number: employee.pis_number,
      summary: %{balance: parse_minute(employee.summary.balance)},
      history: get_history(employee.report, start_date, end_date)
    }
  end

  defp get_history(reports, start_date, end_date) do
    date_range = Date.range(Date.from_iso8601!(start_date), Date.from_iso8601!(end_date))

    Enum.reduce(reports, [], fn {date, report}, history ->
      parse_history(history, report, date, Enum.member?(date_range, date))
    end)
  end

  defp parse_history(history, report, date, true) do
    new_entry = %{
      day: Date.to_string(date),
      balance: parse_minute(report.balance)
    }

    [new_entry | history]
  end

  defp parse_history(history, _, _, false) do
    history
  end

  defp parse_minute(minutes) do
    {signal, minutes} =
      if minutes >= 0 do
        {"", trunc(minutes)}
      else
        {"-", trunc(minutes) * -1}
      end

    hour = String.pad_leading(Integer.to_string(div(minutes, 60)), 2, "0")
    minute = String.pad_leading(Integer.to_string(rem(minutes, 60)), 2, "0")

    "#{signal}#{hour}:#{minute}"
  end

  def to_json(serialized) do
    Poison.encode!(serialized, pretty: true)
  end
end
