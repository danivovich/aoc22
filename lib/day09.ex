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
      start = {[{0, 0}], [{0, 0}]}

      Enum.reduce(moves, start, fn move, data ->
        processMove(data, move)
      end)
    end

    def countTails({_heads, history}) do
      history
      |> Enum.uniq()
      |> Enum.count()
    end

    def processMove(data, {_, 0}) do
      data
    end

    def processMove({heads, _history} = data, {"R", steps}) do
      {r, c} = Enum.at(heads, -1)
      next = {r, c + 1}
      data = updateData(data, {r, c}, next)
      processMove(data, {"R", steps - 1})
    end

    def processMove({heads, _history} = data, {"U", steps}) do
      {r, c} = Enum.at(heads, -1)
      next = {r - 1, c}
      data = updateData(data, {r, c}, next)
      processMove(data, {"U", steps - 1})
    end

    def processMove({heads, _history} = data, {"L", steps}) do
      {r, c} = Enum.at(heads, -1)
      next = {r, c - 1}
      data = updateData(data, {r, c}, next)
      processMove(data, {"L", steps - 1})
    end

    def processMove({heads, _history} = data, {"D", steps}) do
      {r, c} = Enum.at(heads, -1)
      next = {r + 1, c}
      data = updateData(data, {r, c}, next)
      processMove(data, {"D", steps - 1})
    end

    def updateData({headHistory, tailHistory}, current, next) do
      tail = Enum.at(tailHistory, -1)

      case moveTail?(tail, next) do
        true ->
          {List.insert_at(headHistory, -1, next), List.insert_at(tailHistory, -1, current)}

        false ->
          {List.insert_at(headHistory, -1, next), tailHistory}
      end
    end

    def moveTail?({tr, tc}, {hr, hc}) do
      causeRow =
        case hr - tr do
          0 ->
            false

          -1 ->
            false

          1 ->
            false

          _ ->
            true
        end

      causeCol =
        case hc - tc do
          0 ->
            false

          -1 ->
            false

          1 ->
            false

          _ ->
            true
        end

      causeRow || causeCol
    end
  end

  defmodule Part2 do
  end

  def part1 do
    Day09.input()
    |> Day09.Part1.processMoves()
    |> Day09.Part1.countTails()
  end

  def part2 do
    nil
  end
end
