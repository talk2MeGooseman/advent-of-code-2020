defmodule AdventOfCode.Day03 do

  @spec part1(any) :: nil
  def part1(args) do
    x = 3
    y = 1

    map_section = args
    |> parse_rows # [".#.", "#.#", ...]
    |> Enum.map(fn r -> parse_row(r) end) # [[".", "#", "."], ["#", ".", "#"], ...]

    # height = Enum.count(map_section)
    # width = Enum.count(Enum.at(map_section, 0))

    map_section_repeat = 1000

    # build the whole map
    map = map_section
    |> Enum.map( fn row -> List.duplicate(row, map_section_repeat) |> Enum.concat end )

    start_traverse(map, x, y)
  end

  def part2(args) do
  end

  defp parse_rows(s) do
    String.split(s, "\n")
  end

  defp parse_row(s) do
    s
    |> String.trim
    |> String.graphemes
  end

  def start_traverse(map, x_step, y_step) do
    tree_count = 0
    traverse(tree_count, map, %{ x_step: x_step, y_step: y_step }, %{ x: 0, y: 0 })
  end

  def traverse(tree_count, map, _steps, %{ x: _x , y: y }) when length(map) <= y  do
    tree_count
  end

  def traverse(tree_count, map, %{ x_step: x_step, y_step: y_step } = steps, %{ x: x , y: y }) do
    location = Enum.at(map, y)
    |> Enum.at(x)

    is_tree = case location do
      nil -> false
      x when is_bitstring(x) -> String.contains?(location, "#")
    end

    new_tree_count = case is_tree do
      true -> tree_count + 1
      _ -> tree_count
    end

    traverse(new_tree_count, map, steps, %{ x: x + x_step, y: y + y_step })
  end
end
