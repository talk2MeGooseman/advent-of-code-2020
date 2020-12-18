defmodule AdventOfCode.Day03 do

  @spec part1(any) :: nil
  def part1(args) do
    x = 3
    y = 1

    map_section = args
    |> parse_rows
    |> Enum.map(fn r -> parse_row(r) end)

    height = Enum.count(map_section)
    width = Enum.count(Enum.at(map_section, 0))
    map_section_repeat = height * width

    # build the whole map
    map = map_section
    |> Enum.map( fn row ->
      List.duplicate(row, map_section_repeat)
      |> Enum.concat end
    )

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
    new_tree_count = Enum.at(map, y)
    |> Enum.at(x)
    |> String.contains?("#")
    |> update_tree_count(tree_count)

    traverse(new_tree_count, map, steps, %{ x: x + x_step, y: y + y_step })
  end

  defp update_tree_count(is_tree, tree_count) do
    if is_tree, do: tree_count + 1, else: tree_count
  end
end
