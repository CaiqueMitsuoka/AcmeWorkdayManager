defmodule EmployeeTest do
  use ExUnit.Case, async: true
  alias AcmeWorkdayManager.Models.Employee

  setup do
    %{
      employees: [
        %Employee{pis_number: "123", name: "Foo"}
      ]
    }
  end

  describe("Employee.find_by_pis_number/2 when employee exist") do
    setup :pis_number_exist

    test "An employee is returned", context do
      result = AcmeWorkdayManager.Models.Employee.find_by_pis_number(context.employees, "456")

      assert result.name == "Bar"
    end
  end

  describe("Employee.find_by_pis_number/2 when employee doesnt exist") do
    setup :pis_number_doesnt_exist

    test "An employee is returned", context do
      result = AcmeWorkdayManager.Models.Employee.find_by_pis_number(context.employees, "456")

      assert result == nil
    end
  end

  defp pis_number_exist(context) do
    %{employees: [%Employee{pis_number: "456", name: "Bar"} | context.employees]}
  end

  defp pis_number_doesnt_exist(context) do
    context
  end
end
