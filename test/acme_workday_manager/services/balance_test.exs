defmodule BalanceTest do
  use ExUnit.Case, async: true
  alias AcmeWorkdayManager.Service.Balance
  alias AcmeWorkdayManager.Models.Employee
  alias AcmeWorkdayManager.Models.Week

  setup do
    week =
      Week.new()
      |> Week.update_minutes("tue", &(&1 + 10))
      |> Week.update_minutes("wed", &(&1 + 10))
      |> Week.update_minutes("thu", &(&1 + 10))
      |> Week.update_minutes("fri", &(&1 + 10))

    %{
      employee: %Employee{
        report: %{
          Date.from_iso8601!("2018-04-11") => %{
            total_worked_minutes: 10,
            total_rested_minutes: 10
          },
          Date.from_iso8601!("2018-04-12") => %{
            total_worked_minutes: 10,
            total_rested_minutes: 15
          },
          Date.from_iso8601!("2018-04-13") => %{
            total_worked_minutes: 10,
            total_rested_minutes: 5
          },
          Date.from_iso8601!("2018-04-14") => %{
            total_worked_minutes: 15,
            total_rested_minutes: 10
          }
        },
        week_workload: week,
        week_rest: week
      }
    }
  end

  describe "Balance.get_balance/1" do
    test "balance to 00", context do
      employee = Balance.get_balance(context.employee)

      report = Map.get(employee.report, Date.from_iso8601!("2018-04-11"))

      assert report.balance == 0
    end

    test "balance stay 00 when rest exceed", context do
      employee = Balance.get_balance(context.employee)

      report = Map.get(employee.report, Date.from_iso8601!("2018-04-12"))

      assert report.balance == 0
    end

    test "balance gains 5 when rest is less them expected", context do
      employee = Balance.get_balance(context.employee)

      report = Map.get(employee.report, Date.from_iso8601!("2018-04-13"))

      assert report.balance == 5
    end

    test "balance gains 5 when workload is more them expected", context do
      employee = Balance.get_balance(context.employee)

      report = Map.get(employee.report, Date.from_iso8601!("2018-04-13"))

      assert report.balance == 5
    end
  end
end
