defmodule AdventOfCode.Day02 do
  def part1(args) do
    args
    |> parse_rows
    |> Enum.map(fn row -> validate_password?(row) end)
    |> Enum.count(fn result -> result == true end)
  end

  def part2(args) do
    args
    |> parse_rows
    |> Enum.map(fn row -> validate_password2?(row) end)
    |> Enum.count(fn result -> result == true end)
  end

  defp parse_rows(s) do
    String.split(s, "\n")
  end

  def validate_password?(input) do
    input
    |> String.split(":")
    |> Enum.map(fn s -> String.trim(s) end)
    |> check_condition
  end

  defp check_condition([ rule, pw ]) do
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

  def validate_password2?(input) do
    input
    |> String.split(":")
    |> Enum.map(fn s -> String.trim(s) end)
    |> check_condition2
  end

  defp check_condition2([ rule, pw ]) do
    %{ p1: p1, p2: p2, letter: letter } = get_valid_position(rule)

    characters = String.graphemes(pw)
    [Enum.at(characters, p1), Enum.at(characters, p2)]
    |> Enum.count(fn c -> letter == c end)
    |> fn count -> count == 1 end.()
  end

  defp get_valid_position(str) do
    [positions, letter] = String.split(str, " ")

    [p1_str, p2_str] = String.split(positions, "-")

    p1 = String.to_integer(p1_str)
    p2 = String.to_integer(p2_str)

    %{ p1: p1 - 1, p2: p2 - 1, letter: letter }
  end
end
