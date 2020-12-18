defmodule AdventOfCode.Day03 do

  @spec part1(any) :: nil
  def part1(args, x \\ 3, y \\ 1) do
    build_map_terrain(args)
    |> start_traverse(x, y)
  end

  def part2(args) do
    map = build_map_terrain(args)

    [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
    |> Enum.map(fn [x, y] -> start_traverse(map, x, y) end)
    |> Enum.reduce(fn v, acc -> v * acc end)
  end

  defp build_map_terrain(map_string) do
    map_section = parse_map_section(map_string)
    height = Enum.count(map_section)
    width = Enum.count(Enum.at(map_section, 0))
    map_section_repeat = height * width

    # build the whole map
    map_section
    |> Enum.map( fn row ->
      List.duplicate(row, map_section_repeat)
      |> Enum.concat end)
  end

  defp parse_map_section(map_string) do
    map_string
    |> parse_rows
    |> Enum.map(fn r -> parse_row(r) end)
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
