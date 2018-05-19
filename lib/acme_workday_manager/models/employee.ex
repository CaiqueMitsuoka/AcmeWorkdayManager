defmodule AcmeWorkdayManager.Models do
  defmodule Employee do
    defstruct name: nil, pis_number: nil, workload: []

    def new(collection) when is_list(collection) do
      Enum.map(collection, &new(&1))
    end

    def new(%{name: name, pis_number: pis_number, workload: workload}) do
      %Employee{
        name: name,
        pis_number: pis_number,
        workload: workload
      }
    end

    def find_by_pis_number(employee_enum, pis_number) do
      Enum.find(employee_enum, &(&1.pis_number == pis_number))
    end
  end
end
