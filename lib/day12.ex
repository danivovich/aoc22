defmodule Day12 do
  @moduledoc """
  AOC2022 Day 12
  """
  alias Aoc2022.SharedMap

  def input do
    {:ok, contents} = File.read("inputs/day12_input.txt")

    parseInput(contents)
  end

  def example do
    {:ok, contents} = File.read("inputs/day12_example.txt")

    parseInput(contents)
  end

  def history(grid) do
    Enum.each(grid, fn {key, _v} ->
      SharedMap.set(key, :math.pow(2, :erlang.system_info(:wordsize) * 8))
    end)
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

  def getTarget(grid) do
    Enum.find(grid, fn {_k, v} -> v == "E" end)
  end

  def getStart(grid) do
    Enum.find(grid, fn {_k, v} -> v == "S" end)
  end

  def moveToTarget(_grid, current, target) when current == target do
    SharedMap.get(target)
  end

  def moveToTarget(grid, current, target) do
    options = getOptions(grid, current)

    case options do
      [] ->
        :stop

      options ->
        options
        |> Enum.map(fn {r, c, d} ->
          SharedMap.set({r, c}, d)
          {r, c, d}
        end)
        |> Enum.map(fn {r, c, _d} ->
          moveToTarget(grid, {r, c}, target)
        end)
    end
  end

  def getOptions(grid, {r, c} = current) do
    currentValue =
      grid
      |> cellAt(current)
      |> :binary.first()

    distance = SharedMap.get(current)

    [
      {r, c - 1, distance + 1},
      {r, c + 1, distance + 1},
      {r - 1, c, distance + 1},
      {r + 1, c, distance + 1}
    ]
    |> Enum.filter(fn {x, y, _d} ->
      Map.has_key?(grid, {x, y})
    end)
    |> Enum.filter(fn {x, y, _d} ->
      v =
        grid
        |> cellAt({x, y})
        |> :binary.first()

      v - currentValue <= 1
    end)
    |> Enum.filter(fn {x, y, d} ->
      d < SharedMap.get({x, y})
    end)
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
      SharedMap.start()
      grid = Day12.example()
      {target, _v} = Day12.getTarget(grid)
      {start, _v} = Day12.getStart(grid)

      Day12.history(grid)
      SharedMap.set(start, 0)

      Day12.moveToTarget(grid, start, target)
      result = SharedMap.get(target)
      SharedMap.clear()
      result
    end
  end

  defmodule Part2 do
  end

  def part1 do
    SharedMap.start()
    grid = Day12.input()
    {target, _v} = Day12.getTarget(grid)
    {start, _v} = Day12.getStart(grid)

    Day12.history(grid)
    SharedMap.set(start, 0)

    Day12.moveToTarget(grid, start, target)
    result = SharedMap.get(target)
    SharedMap.clear()
    result
  end

  def part2 do
  end
end
