defmodule Day09 do
  @moduledoc """
  AOC2022 Day 9
  """

  def input do
    {:ok, contents} = File.read("inputs/day09_input.txt")

    parseInput(contents)
  end

  def example do
    {:ok, contents} = File.read("inputs/day09_example.txt")

    parseInput(contents)
  end

  def parseInput(contents) do
    contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [dir, steps_string] = String.split(line, " ", trim: true)
      {steps, _} = Integer.parse(steps_string)
      {dir, steps}
    end)
  end

  def processMoves(moves, ropeLength) do
    rope =
      Range.new(1, ropeLength)
      |> Enum.map(fn _i ->
        {0, 0}
      end)

    visited =
      MapSet.new()
      |> MapSet.put({0, 0})

    data = %{rope: rope, visited: visited}

    Enum.reduce(moves, data, fn move, data ->
      processMove(data, move)
    end)
  end

  def countTails(%{rope: _rope, visited: visited}) do
    visited
    |> Enum.count()
  end

  def processMove(data, {dir, steps}) do
    Range.new(1, steps)
    |> Enum.reduce(data, fn _step, data ->
      data[:rope]
      |> moveHead(dir)
      |> updateKnots()
      |> visitTail(data[:visited])
    end)
  end

  def updateKnots([head, tail]) do
    case adjacent(head, tail) do
      true ->
        [head, tail]

      false ->
        moveTowardHead(tail, head)
    end
  end

  def updateKnots([head | remainingRope]) do
    {next, remain} = List.pop_at(remainingRope, 0)

    case adjacent(head, next) do
      true ->
        Enum.concat([head], updateKnots(remainingRope))

      false ->
        [head, newNext] = moveTowardHead(next, head)
        newRemain = Enum.concat([newNext], remain)
        Enum.concat([head], updateKnots(newRemain))
    end
  end

  @doc """
  Move a knot in the direction of the one before it

  ## Examples

      iex> Day09.adjacent({-1, -1}, {0, 0})
      true
      iex> Day09.adjacent({1, -1}, {0, 0})
      true
      iex> Day09.adjacent({1, 1}, {0, 0})
      true
      iex> Day09.adjacent({1, 0}, {0, 0})
      true
      iex> Day09.adjacent({-1, 0}, {0, 0})
      true
      iex> Day09.adjacent({2, 0}, {0, 0})
      false
      iex> Day09.adjacent({-2, 0}, {0, 0})
      false
  """
  def adjacent({r, c}, two) do
    adjs = [
      {r - 1, c - 1},
      {r, c - 1},
      {r + 1, c - 1},
      {r - 1, c},
      {r, c},
      {r + 1, c},
      {r - 1, c + 1},
      {r, c + 1},
      {r + 1, c + 1}
    ]

    Enum.any?(adjs, fn v -> v == two end)
  end

  @doc """
  Move a knot in the direction of the one before it

  ## Examples

      iex> Day09.moveTowardHead({4, 0}, {4, 2})
      [{4, 2}, {4, 1}]
      iex> Day09.moveTowardHead({0, 0}, {-2, 0})
      [{-2, 0}, {-1, 0}]
      iex> Day09.moveTowardHead({0, 1}, {-2, 0})
      [{-2, 0}, {-1, 0}]
      iex> Day09.moveTowardHead({0, 1}, {-2, 2})
      [{-2, 2}, {-1, 2}]
  """
  def moveTowardHead({tr, tc}, {hr, hc}) when tr == hr do
    case hc > tc do
      true ->
        [{hr, hc}, {tr, tc + 1}]

      false ->
        [{hr, hc}, {tr, tc - 1}]
    end
  end

  def moveTowardHead({tr, tc}, {hr, hc}) when hc == tc do
    case hr > tr do
      true ->
        [{hr, hc}, {tr + 1, tc}]

      false ->
        [{hr, hc}, {tr - 1, tc}]
    end
  end

  def moveTowardHead({tr, tc}, {hr, hc}) do
    dr = hr - tr
    dc = hc - tc

    newR =
      case dr > 0 do
        true ->
          1

        false ->
          -1
      end

    newC =
      case dc > 0 do
        true ->
          1

        false ->
          -1
      end

    [{hr, hc}, {tr + newR, tc + newC}]
  end

  @doc """
  Record a tail visit

  ## Examples

      iex> Day09.visitTail([{0, 0}], MapSet.new())
      %{rope: [{0, 0}], visited: MapSet.new([{0, 0}])}
      iex> Day09.visitTail([{0, 0}, {1, 1}], MapSet.new([{0, 0}]))
      %{rope: [{0, 0}, {1, 1}], visited: MapSet.new([{0, 0}, {1, 1}])}
      iex> Day09.visitTail([{0, 0}, {1, 1}, {1, 1}], MapSet.new([{0, 0}]))
      %{rope: [{0, 0}, {1, 1}, {1, 1}], visited: MapSet.new([{0, 0}, {1, 1}])}

  """
  def visitTail(rope, visited) do
    tail = Enum.at(rope, -1)
    %{rope: rope, visited: MapSet.put(visited, tail)}
  end

  @doc """
  Move head of rope

  ## Examples

      iex> Day09.moveHead([{0, 0}], "R")
      [{0, 1}]
      iex> Day09.moveHead([{0, 0}], "D")
      [{1, 0}]
      iex> Day09.moveHead([{0, 0}], "U")
      [{-1, 0}]
      iex> Day09.moveHead([{0, 0}], "L")
      [{0, -1}]

  """
  def moveHead(rope, "R") do
    {r, c} = Enum.at(rope, 0)
    next = {r, c + 1}
    List.replace_at(rope, 0, next)
  end

  def moveHead(rope, "U") do
    {r, c} = Enum.at(rope, 0)
    next = {r - 1, c}
    List.replace_at(rope, 0, next)
  end

  def moveHead(rope, "L") do
    {r, c} = Enum.at(rope, 0)
    next = {r, c - 1}
    List.replace_at(rope, 0, next)
  end

  def moveHead(rope, "D") do
    {r, c} = Enum.at(rope, 0)
    next = {r + 1, c}
    List.replace_at(rope, 0, next)
  end

  defmodule Part1 do
    @doc """
    Example Inputs for Part 1

    ## Examples

        iex> Day09.Part1.example()
        13

    """
    def example() do
      Day09.example()
      |> Day09.processMoves(2)
      |> Day09.countTails()
    end
  end

  defmodule Part2 do
    def input() do
      {:ok, contents} = File.read("inputs/day09_example2.txt")

      Day09.parseInput(contents)
    end

    @doc """
    Example Inputs for Part 2

    ## Examples

        iex> Day09.Part2.example()
        36

    """
    def example() do
      Day09.Part2.input()
      |> Day09.processMoves(10)
      |> Day09.countTails()
    end
  end

  def part1 do
    Day09.input()
    |> Day09.processMoves(2)
    |> Day09.countTails()
  end

  def part2 do
    Day09.input()
    |> Day09.processMoves(10)
    |> Day09.countTails()
  end
end
