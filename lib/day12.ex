defmodule Day12 do
  @moduledoc """
  AOC2022 Day 12
  """

  def input do
    {:ok, contents} = File.read("inputs/day12_input.txt")

    parseInput(contents)
  end

  def example do
    {:ok, contents} = File.read("inputs/day12_example.txt")

    parseInput(contents)
  end

  def history(grid) do
    Enum.map(grid, fn row ->
      Enum.map(row, fn _i -> "." end)
    end)
  end

  def parseInput(contents) do
    contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      String.split(row, "", trim: true)
    end)
  end

  def print(grid) do
    IO.puts("")

    Enum.map(grid, fn row ->
      Enum.join(row, "")
    end)
    |> Enum.join("\n")
    |> IO.puts()

    grid
  end

  def getTarget(grid) do
    row =
      Enum.find_index(grid, fn row ->
        Enum.member?(row, "E")
      end)

    col =
      Enum.find_index(Enum.at(grid, row), fn col ->
        col == "E"
      end)

    {row, col}
  end

  def moveToTarget(_grid, history, moves, current, target) when current == target do
    {moves, history}
  end

  def moveToTarget(grid, history, moves, current, target) do
    moveOptions = getOptions(grid, history, current)

    case length(moveOptions) == 0 do
      true ->
        nil

      false ->
        Enum.map(moveOptions, fn {r, c, d} ->
          row = Enum.at(history, r)
          col = List.replace_at(row, c, d)
          newHistory = List.replace_at(history, r, col)
          moveToTarget(grid, newHistory, moves + 1, {r, c}, target)
        end)
        |> Enum.filter(fn x -> x != nil end)
        |> Enum.min_by(fn {moves, _history} -> moves end, fn -> nil end)
    end
  end

  def countMoves({_m, history}) do
    Enum.map(history, fn row ->
      Enum.map(row, fn cell -> Day12.count(cell) end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def getOptions(grid, history, {r, c} = current) do
    currentValue =
      grid
      |> cellAt(current)
      |> :binary.first()

    [
      {r, c - 1, "<"},
      {r, c + 1, ">"},
      {r - 1, c, "^"},
      {r + 1, c, "v"}
    ]
    |> Enum.filter(fn {x, y, _d} ->
      x >= 0 and y >= 0 and x < length(grid) and y < length(Enum.at(grid, 0))
    end)
    |> Enum.filter(fn {x, y, _d} ->
      case cellAt(history, {x, y}) do
        "." ->
          true

        _ ->
          false
      end
    end)
    |> Enum.filter(fn {x, y, _d} ->
      v =
        grid
        |> cellAt({x, y})
        |> :binary.first()

      case v <= currentValue do
        true ->
          true

        false ->
          v - currentValue == 1
      end
    end)
  end

  def cellAt(grid, {r, c}) do
    v =
      grid
      |> Enum.at(r)
      |> Enum.at(c)

    case v do
      "S" ->
        # Use something smaller than a for the start point
        "`"

      "E" ->
        # E has an elevation of z
        "z"

      v ->
        v
    end
  end

  def count("."), do: 0
  def count("E"), do: 0
  def count(">"), do: 1
  def count("^"), do: 1
  def count("<"), do: 1
  def count("v"), do: 1

  defmodule Part1 do
    @doc """
    Example Inputs for Part 1

    ## Examples

        iex> Day12.Part1.example()
        31

    """
    def example() do
      grid = Day12.example()
      target = Day12.getTarget(grid)

      {moves, _history} =
        grid
        |> Day12.moveToTarget(Day12.history(grid), 0, {0, 0}, target)

      moves
    end
  end

  defmodule Part2 do
  end

  def part1 do
  end

  def part2 do
  end
end
