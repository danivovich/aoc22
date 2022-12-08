defmodule Day08 do
  @moduledoc """
  AOC2022 Day 8
  """

  def input do
    {:ok, contents} = File.read("inputs/day08_input.txt")

    contents
    |> processMap()
  end

  def example do
    {:ok, contents} = File.read("inputs/day08_example.txt")

    contents
    |> processMap()
  end

  def processMap(input) do
    rows =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn row ->
        row
        |> String.split("", trim: true)
        |> Enum.map(fn tree ->
          {height, _} = Integer.parse(tree)
          height
        end)
      end)

    columns =
      Range.new(0, length(Enum.at(rows, 0)) - 1)
      |> Enum.map(fn c ->
        Enum.map(rows, fn row ->
          Enum.at(row, c)
        end)
      end)

    {rows, columns}
  end

  defmodule Part1 do
    @doc """
    Example Inputs

    ## Examples

        iex> Day08.Part1.example()
        21

    """
    def example() do
      Day08.example()
      |> countVisible()
    end

    def countVisible({rows, columns}) do
      row_count = length(rows)
      column_count = length(columns)

      Range.new(0, row_count - 1)
      |> Enum.map(fn r ->
        Range.new(0, column_count - 1)
        |> Enum.map(fn c ->
          row = Enum.at(rows, r)
          column = Enum.at(columns, c)
          tree = Enum.at(row, c)
          {trees_above, trees_below} = treesAround(column, r)
          {trees_left, trees_right} = treesAround(row, c)
          ns = isVisible(tree, trees_above, trees_below)
          ew = isVisible(tree, trees_left, trees_right)

          case ns || ew do
            true ->
              1

            false ->
              0
          end
        end)
        |> Enum.sum()
      end)
      |> Enum.sum()
    end

    def isVisible(_tree, [], _), do: true
    def isVisible(_tree, _, []), do: true

    @doc """
    Example Inputs

    ## Examples

        iex> Day08.Part1.isVisible(3, [], [0, 3, 7, 3])
        true
        iex> Day08.Part1.isVisible(3, [3, 0, 3, 7], [])
        true
        iex> Day08.Part1.isVisible(5, [0], [5, 3, 5])
        true
        iex> Day08.Part1.isVisible(1, [7], [3, 4, 9])
        false
        iex> Day08.Part1.isVisible(3, [1], [3, 4, 9])
        true
        iex> Day08.Part1.isVisible(1, [2, 3], [4, 9])
        false

    """
    def isVisible(tree, other, other_other) do
      Enum.all?(other, fn x -> x < tree end) or
        Enum.all?(other_other, fn y -> y < tree end)
    end

    @doc """
    Example Inputs

    ## Examples

        iex> Day08.Part1.treesAround([1, 2, 3, 4], 0)
        {[], [2, 3, 4]}
        iex> Day08.Part1.treesAround([1, 2, 3, 4], 1)
        {[1], [3, 4]}
        iex> Day08.Part1.treesAround([1, 2, 3, 4], 3)
        {[1, 2, 3], []}

    """
    def treesAround(data, 0) do
      {[], Enum.drop(data, 1)}
    end

    def treesAround(data, pos) do
      {left, right} = Enum.split(data, pos)
      {left, Enum.drop(right, 1)}
    end
  end

  defmodule Part2 do
  end

  def part1 do
    input()
    |> Day08.Part1.countVisible()
  end

  def part2 do
    input()
  end
end
