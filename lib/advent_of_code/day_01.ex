defmodule AdventOfCode.Day01 do
  def part1(args) do
    result = parse_numbers(args)
    |> get_two_values_for_sum(2020)
    IO.puts result
  end

  defp parse_numbers(s) do
    s
    |> String.split("\n")
    |> Enum.map(fn num -> String.to_integer(String.trim(num)) end)
  end

  defp get_two_values_for_sum(list, desired_sum) do
    set = MapSet.new
    get_two_values_for_sum(list, desired_sum, set)
  end

  defp get_two_values_for_sum([], desired_sum, set) do
    nil
  end

  defp get_two_values_for_sum([value | list], desired_sum, set) do
    case MapSet.member?(set, desired_sum - value) do
      false -> get_two_values_for_sum(list, desired_sum, MapSet.put(set, value))
      true -> value * (desired_sum - value)
    end
  end

  def find_value_trio([], _target) do
    nil
  end

  def find_value_trio([ value1 | numbers]) do
    target = 2020 - value1
    result = get_two_values_for_sum(numbers, target)

    case result do
      nil -> find_value_trio(numbers)
      _ -> value1 * result
    end
  end

  def part2(args) do
    result = parse_numbers(args)
    |> find_value_trio
    IO.puts result
  end
end
