defmodule EntriesTest do
  use ExUnit.Case, async: true
  alias AcmeWorkdayManager.Service.Entries
  alias AcmeWorkdayManager.Models.Employee

  def to_datetime(datetime) do
    DateTime.from_naive!(NaiveDateTime.from_iso8601!(datetime), "Etc/UTC")
  end

  setup do
    %{
      employee: %Employee{
        entries: [
          to_datetime("2018-04-10 05:43:00Z"),
          to_datetime("2018-04-10 11:05:00Z"),
          to_datetime("2018-04-10 09:28:00Z"),
          to_datetime("2018-04-10 09:46:00Z")
        ]
      }
    }
  end

  describe("Entries.get_work_report/1") do
    test "it returns the correct worked minutes", context do
      employee = Entries.get_work_report(context.employee)

      day = Map.get(employee.report, DateTime.to_date(to_datetime("2018-04-10 05:43:00Z")))

      assert day.total_worked_minutes == 304
    end

    test "it returns the correct rested minutes", context do
      employee = Entries.get_work_report(context.employee)

      day = Map.get(employee.report, DateTime.to_date(to_datetime("2018-04-10 05:43:00Z")))

      assert day.total_rested_minutes == 18
    end
  end
end
