defmodule AdventOfCode.Day04 do

  def part1(args) do
    args
    |> parse_passports
    |> Enum.map(fn p -> validate(p) end)
    |> Enum.count(fn x -> x == true end)
  end

  defp parse_passports(input) do
    input
    |> String.split(~r{\n\n})
    |> Enum.map(fn p -> format_passport(p) end)
  end

  defp format_passport(input) do
    input
    |> String.split(~r{(\n|\s)})
    |> Enum.reduce(%{}, fn v, acc -> format_data_field(v, acc) end)
  end

  defp format_data_field(input, acc) do
    [key, value] = input |> String.split(":")
    Map.put(acc, key, value)
  end

  defp validate(passport) do
    required_field = [:byr, :iyr, :eyr , :hgt, :hcl, :ecl, :pid]

    Enum.all?(required_field, fn field -> Map.has_key?(passport, to_string(field)) end)
  end

  def part2(args) do
  end
end
