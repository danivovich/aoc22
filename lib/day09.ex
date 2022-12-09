defmodule Day09 do
  @moduledoc """
  AOC2022 Day 9
  """

  def startingGrid() do
    [
      [".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", "."],
      ["H", ".", ".", ".", ".", "."]
    ]
  end

  def startingHistory() do
    [
      [".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", "."],
      ["s", ".", ".", ".", ".", "."]
    ]
  end

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

  defmodule Part1 do
    @doc """
    Example Inputs for Part 1

    ## Examples

        iex> Day09.Part1.example()
        13

    """
    def example() do
      Day09.example()
      |> processMoves()
      |> countTails()
    end

    def processMoves(moves) do
      start = {Day09.startingGrid(), Day09.startingHistory()}

      Enum.reduce(moves, start, fn move, {grid, _history} = data ->
        currentHead = currentPos(grid)
        processMove(data, move, currentHead, currentHead)
      end)
    end

    def countTails({_grid, history}) do
      Enum.reduce(history, 0, fn row, acc ->
        count =
          row
          |> Enum.filter(fn c -> c == "#" or c == "s" end)
          |> Enum.count()

        acc + count
      end)
    end

    @doc """
    Find the current position

    ## Examples

        iex> Day09.Part1.currentPos(Day09.startingGrid())
        {4, 0}

    """
    def currentPos(grid) do
      row =
        Enum.find_index(grid, fn row ->
          case Enum.find_index(row, fn col -> col == "s" or col == "H" end) do
            nil ->
              false

            _ ->
              true
          end
        end)

      col = Enum.find_index(Enum.at(grid, row), fn col -> col == "s" or col == "H" end)
      {row, col}
    end

    def processMove(data, {_, 0}, _current, _previous) do
      data
    end

    def processMove({grid, history}, {"R", steps}, {r, c} = current, previous) do
      next = {r, c + 1}
      data = updateData(grid, history, current, next, previous)
      processMove(data, {"R", steps - 1}, next, current)
    end

    def processMove({grid, history}, {"U", steps}, {r, c} = current, previous) do
      next = {r - 1, c}
      data = updateData(grid, history, current, next, previous)
      processMove(data, {"U", steps - 1}, next, current)
    end

    def processMove({grid, history}, {"L", steps}, {r, c} = current, previous) do
      next = {r, c - 1}
      data = updateData(grid, history, current, next, previous)
      processMove(data, {"L", steps - 1}, next, current)
    end

    def processMove({grid, history}, {"D", steps}, {r, c} = current, previous) do
      next = {r + 1, c}
      data = updateData(grid, history, current, next, previous)
      processMove(data, {"D", steps - 1}, next, current)
    end

    def updateData(grid, history, {rindex, cindex} = _current, {x, y} = _next, {z, q} = _previous) do
      grid =
        grid
        |> Enum.with_index(fn row, r ->
          case r == z do
            false ->
              row

            true ->
              List.replace_at(row, q, "T")
          end
        end)
        |> Enum.with_index(fn row, r ->
          case r == x do
            false ->
              row

            true ->
              List.replace_at(row, y, "H")
          end
        end)

      history =
        history
        |> Enum.with_index(fn row, r ->
          case r == rindex do
            false ->
              row

            true ->
              List.replace_at(row, cindex, "#")
          end
        end)

      {grid, history}
    end
  end

  defmodule Part2 do
  end

  def part1 do
    nil
  end

  def part2 do
    nil
  end
end
