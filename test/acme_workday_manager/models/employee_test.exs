defmodule EmployeeTest do
  use ExUnit.Case, async: true
  alias AcmeWorkdayManager.Models.Employee

  describe "Employee.new/1" do
    setup do
      %{
        employee: %{
          workload: [
            %{
              workload_in_minutes: 90,
              minimum_rest_interval_in_minutes: 10,
              days: ["mon", "fri"]
            }
          ],
          pis_number: "123",
          name: "Foo Bar"
        }
      }
    end

    test("it add the week_workload correct", context) do
      employee = Employee.new(context.employee)

      assert employee.week_workload.mon == 90
      assert employee.week_workload.fri == 90
    end

    test("it add the week_rest correct", context) do
      employee = Employee.new(context.employee)

      assert employee.week_rest.mon == 10
      assert employee.week_rest.fri == 10
    end
  end

  defp employees_list(_) do
    %{employees: [%Employee{pis_number: "123", name: "Foo"}]}
  end

  describe("Employee.find_by_pis_number/2 when employee doesnt exist") do
    setup :employees_list

    test "An employee is returned", context do
      result = AcmeWorkdayManager.Models.Employee.find_by_pis_number(context.employees, "456")

      assert result == nil
    end
  end

  defp pis_number_exist(context) do
    %{employees: [%Employee{pis_number: "456", name: "Bar"} | context.employees]}
  end

  describe("Employee.find_by_pis_number/2 when employee exist") do
    setup [:employees_list, :pis_number_exist]

    test "An employee is returned", context do
      result = AcmeWorkdayManager.Models.Employee.find_by_pis_number(context.employees, "456")

      assert result.name == "Bar"
    end
  end
end
