defmodule AcmeWorkdayManager.Service.Summary do
  alias AcmeWorkdayManager.Models.Employee

  def get_summary(employees, start_date, end_date) do
    date_range = Date.range(Date.from_iso8601!(start_date), Date.from_iso8601!(end_date))

    Enum.map(employees, sum_period_balance(date_range))
  end

  defp sum_period_balance(period) do
    fn employee ->
      balance =
        Enum.reduce(employee.report, 0, fn {date, report}, balance_sum ->
          balance_sum + quantity_to_sum(report, Enum.member?(period, date))
        end)

      %Employee{
        employee
        | summary: %{balance: balance}
      }
    end
  end

  defp quantity_to_sum(report, true) do
    report.balance
  end

  defp quantity_to_sum(_, false) do
    0
  end
end
