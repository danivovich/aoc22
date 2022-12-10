defmodule Day10 do
  @moduledoc """
  AOC2022 Day 10
  """

  def input do
    {:ok, contents} = File.read("inputs/day10_input.txt")

    parseInput(contents)
  end

  def example do
    {:ok, contents} = File.read("inputs/day10_example.txt")

    parseInput(contents)
  end

  def parseInput(contents) do
    contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      case line do
        "noop" ->
          :noop

        addx ->
          [_, amount] = String.split(addx, " ", trim: true)
          {i, _} = Integer.parse(amount)
          {:addx, i}
      end
    end)
  end

  def runCycles(commands) do
    commands
    |> Enum.reduce([0, 1], fn command, registerHistory ->
      x = Enum.at(registerHistory, -1)

      case command do
        :noop ->
          Enum.concat(registerHistory, [x])

        {:addx, v} ->
          Enum.concat(registerHistory, [x, x + v])
      end
    end)
  end

  def signalStrength(values, cycles) do
    cycles
    |> Enum.map(fn c ->
      Enum.at(values, c) * c
    end)
    |> Enum.sum()
  end

  defmodule Part1 do
    @doc """
    Example Inputs for Part 1

    ## Examples

        iex> Day10.Part1.example()
        13140

    """
    def example() do
      Day10.example()
      |> Day10.runCycles()
      |> Day10.signalStrength([20, 60, 100, 140, 180, 220])
    end

    @doc """
    Demo for part 1

    ## Examples

        iex> Day10.Part1.demo()
        [0, 1, 1, 1, 4, 4, -1]
    """
    def demo() do
      contents = """
      noop
      addx 3
      addx -5
      """

      Day10.parseInput(contents)
      |> Day10.runCycles()
    end
  end

  def print([_zerocycle | cycles]) do
    cycles
    |> Enum.with_index()
    |> Enum.map(fn {register, cycle} ->
      pos = rem(cycle, 40)
      sprite = [register - 1, register, register + 1]

      case Enum.find(sprite, fn s -> s == pos end) do
        nil ->
          "."

        _ ->
          "#"
      end
    end)
    |> Enum.join("")
    |> String.codepoints()
    |> Enum.chunk_every(40)
    |> Enum.map(&Enum.join/1)
  end

  defmodule Part2 do
    def output do
      [
        "##..##..##..##..##..##..##..##..##..##..",
        "###...###...###...###...###...###...###.",
        "####....####....####....####....####....",
        "#####.....#####.....#####.....#####.....",
        "######......######......######......####",
        "#######.......#######.......#######.....",
        "."
      ]
    end

    @doc """
    Example Inputs for Part 2

    ## Examples

        iex> Day10.Part2.example()
        Day10.Part2.output()

    """
    def example() do
      Day10.example()
      |> Day10.runCycles()
      |> Day10.print()
    end
  end

  def part1 do
    Day10.input()
    |> Day10.runCycles()
    |> Day10.signalStrength([20, 60, 100, 140, 180, 220])
  end

  def part2 do
    Day10.input()
    |> Day10.runCycles()
    |> Day10.print()
  end
end
