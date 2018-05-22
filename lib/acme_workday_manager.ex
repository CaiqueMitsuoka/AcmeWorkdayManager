defmodule AcmeWorkdayManager do
  def init(config, data) do
    config = AcmeWorkdayManager.Config.open(config)

    %{
      config: config,
      employees:
        config.employees
        |> AcmeWorkdayManager.Models.Employee.new()
        |> AcmeWorkdayManager.Timeclock.add_entries_to(data)
        |> Enum.map(&AcmeWorkdayManager.Service.Entries.get_work_report/1)
        |> Enum.map(&AcmeWorkdayManager.Service.Balance.get_balance/1)
        |> AcmeWorkdayManager.Service.Summary.get_summary(config.period_start, config.today)
    }
  end
end
