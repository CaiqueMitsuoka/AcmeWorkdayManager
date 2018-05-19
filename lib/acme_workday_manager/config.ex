defmodule AcmeWorkdayManager.Config do
  def open(file_path) do
    {:ok, config_json} = File.read(file_path)

    Poison.decode!(config_json, keys: :atoms)
  end
end
