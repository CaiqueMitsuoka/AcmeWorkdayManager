defmodule ReportTask do
  use ExCLI.DSL, mix_task: :report

  default_command(:all)

  option(:config, required: true, aliases: [:c], default: "config.json")
  option(:data, required: true, aliases: [:d], default: "timeclock_entries.json")

  command :all do
    aliases([:a])
    description("Timeclock report of all users")

    long_description("""
    Print the balance json of all employees

    Options:
    -c, --config file     default: config.json
    -d, --data file       default: timeclock_entries.json
    """)

    run context do
      AcmeWorkdayManager.init(context.config, context.data)
      |> AcmeWorkdayManager.Cli.All.show()
      |> IO.puts()
    end
  end
end
