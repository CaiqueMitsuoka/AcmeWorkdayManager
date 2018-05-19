defmodule ConfigTest do
  use ExUnit.Case, async: true

  setup do
    %{file_path: "test/fixtures/config.json"}
  end

  describe("AcmeWorkdayManager.Config.open/1") do
    test "it reads configuration json and use atom as keys", context do
      parsed_json = AcmeWorkdayManager.Config.open(context.file_path)

      assert parsed_json.today == "2018-05-20"
    end
  end
end
