defmodule AcmeWorkdayManager.Service.Balance do
  alias AcmeWorkdayManager.Models.Employee
  alias AcmeWorkdayManager.Models.Week

  def get_balance(employee) do
    update_report(employee, add_load_to_report(employee))
  end

  defp update_report(employee, reduce_function) do
    %Employee{
      employee
      | report: Enum.reduce(employee.report, %{}, reduce_function)
    }
  end

  defp add_load_to_report(employee) do
    fn {date, report}, reports ->
      weekday_number = Date.day_of_week(date)
      workload = Week.get(employee.week_workload, weekday_number)
      rest = Week.get(employee.week_rest, weekday_number)

      new_report = %{
        workload: workload,
        rest: rest,
        balance:
          calculate_day_balance(
            report.total_worked_minutes,
            workload,
            report.total_rested_minutes,
            rest
          )
      }

      Map.put(reports, date, Map.merge(report, new_report))
    end
  end

  defp calculate_day_balance(total_worked_minutes, workload, total_rested_minutes, rest) do
    work_balance = total_worked_minutes - workload
    rest_balance = (total_rested_minutes - rest) * -1

    if rest_balance < 0 do
      work_balance
    else
      work_balance + rest_balance
    end
  end
end
