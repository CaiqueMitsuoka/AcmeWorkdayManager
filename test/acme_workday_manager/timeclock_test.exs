defmodule TimeclockTest do
  use ExUnit.Case, async: true
  alias AcmeWorkdayManager.Timeclock
  alias AcmeWorkdayManager.Models.Employee

  setup do
    %{
      file_path: "test/fixtures/timeclock.json",
      employees: [%Employee{pis_number: "123"}]
    }
  end

  describe("Timeclock.add_entries_to/2") do
    test "it return a list of employees with the entries", context do
      employees = Timeclock.add_entries_to(context.employees, context.file_path)

      assert List.first(employees).entries == [
               to_datetime("2018-04-10T05:43:00"),
               to_datetime("2018-04-10T09:28:00"),
               to_datetime("2018-04-10T09:46:00"),
               to_datetime("2018-04-10T11:05:00")
             ]
    end
  end

  def to_datetime(datetime) do
    DateTime.from_naive!(NaiveDateTime.from_iso8601!(datetime), "Etc/UTC")
  end
end
