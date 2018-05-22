defmodule AcmeWorkdayManager.Cli.All do
  def show(payload) do
    payload.employees
    |> AcmeWorkdayManager.EmployeeSerializer.new(
      payload.config.period_start,
      payload.config.today
    )
    |> AcmeWorkdayManager.EmployeeSerializer.to_json()
  end
end
