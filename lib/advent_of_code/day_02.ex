defmodule AdventOfCode.Day02 do
  def part1(args) do
    args
    |> parse_rows
    |> Enum.map(fn row -> validate_passwords?(row) end)
    |> Enum.count(fn result -> result == true end)
  end

  def part2(args) do
  end

  defp parse_rows(s) do
    String.split(s, "\n")
  end

  def validate_passwords?(input) do
    input
    |> String.split(":")
    |> Enum.map(fn s -> String.trim(s) end)
    |> validate_password
  end

  defp validate_password([ rule, pw ]) do
    %{ range: range, letter: letter } = get_min_max_letter(rule)

    count = String.graphemes(pw)
    |> Enum.count(fn l -> l == letter end)

    Enum.member?(range, count)
  end

  defp get_min_max_letter(str) do
    [range_str, letter] = String.split(str, " ")

    [min_str, max_str] = String.split(range_str, "-")

    min = String.to_integer(min_str)
    max = String.to_integer(max_str)

    %{ range: min..max, letter: letter }
  end

end
