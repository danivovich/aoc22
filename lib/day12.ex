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
    Enum.map(grid, fn {key, _v} ->
      {key, "."}
    end)
    |> Map.new()
  end

  def parseInput(contents) do
    contents
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, r} ->
      row
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {v, c} ->
        {{r, c}, v}
      end)
    end)
    |> Map.new()
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
    Enum.find(grid, fn {_k, v} -> v == "E" end)
  end

  def getStart(grid) do
    Enum.find(grid, fn {_k, v} -> v == "S" end)
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
          newHistory = Map.put(history, {r, c}, d)
          moveToTarget(grid, newHistory, moves + 1, {r, c}, target)
        end)
        |> Enum.filter(fn x -> x != nil end)
        |> Enum.min_by(fn {moves, _history} -> moves end, fn -> nil end)
    end
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
    # |> IO.inspect(label: "Options")
    |> Enum.filter(fn {x, y, _d} ->
      Map.has_key?(grid, {x, y})
    end)
    # |> IO.inspect(label: "In Grid")
    |> Enum.filter(fn {x, y, _d} ->
      case cellAt(history, {x, y}) do
        "." ->
          true

        _ ->
          false
      end
    end)
    # |> IO.inspect(label: "Unvisted")
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

    # |> IO.inspect(label: "Climbable")
  end

  def cellAt(grid, key) do
    v = Map.get(grid, key)

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

  defmodule Part1 do
    @doc """
    Example Inputs for Part 1

    ## Examples

        iex> Day12.Part1.example()
        31

    """
    def example() do
      grid = Day12.example()
      {target, _v} = Day12.getTarget(grid)
      {start, _v} = Day12.getStart(grid)
      history = Day12.history(grid)

      {moves, _history} =
        grid
        |> Day12.moveToTarget(history, 0, start, target)

      moves
    end
  end

  defmodule Part2 do
  end

  def part1 do
    grid = Day12.input()
    {target, _v} = Day12.getTarget(grid)
    {start, _v} = Day12.getStart(grid)

    history = Day12.history(grid)

    {moves, _history} =
      grid
      |> Day12.moveToTarget(Day12.history(grid), 0, start, target)
      |> Day12.moveToTarget(history, 0, start, target)

    moves
  end

  def part2 do
  end
end
