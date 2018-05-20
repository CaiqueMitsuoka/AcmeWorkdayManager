defmodule WeekTest do
  use ExUnit.Case, async: true
  alias AcmeWorkdayManager.Models.Week

  describe "Week.update_minutes/3" do
    test "update the week day" do
      week = Week.new()
      day = "mon"
      update_lambda = &(&1 + 10)

      result = Week.update_minutes(week, day, update_lambda)

      assert result.mon == 10
    end
  end
end
