defmodule Day02 do
  @moduledoc """
  AOC2022 Day 2
  """

  @doc """
  Parse input

  ## Examples

      iex> Day02.parse("A Y\\nB X\\nC Z")
      [["A", "Y"], ["B", "X"], ["C", "Z"]]

  """
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      String.split(s, " ", trim: true)
    end)
  end

  def input do
    {:ok, contents} = File.read("inputs/day02_input.txt")
    parse(contents)
  end

  defmodule Part1 do
    @moduledoc """
    AOC2022 Day 2 Part 1
    """

    @doc """
    Readme example part1

    ## Examples

        iex> Day02.Part1.example()
        15

    """
    def example() do
      Day02.parse("A Y\nB X\nC Z")
      |> score()
    end

    def score(input) do
      Enum.map(input, fn hands ->
        match(hands)
      end)
      |> Enum.sum()
    end

    # You Win
    def match(["A", "Y"]), do: 8
    def match(["B", "Z"]), do: 9
    def match(["C", "X"]), do: 7

    # Opponent Wins
    def match(["A", "Z"]), do: 3
    def match(["B", "X"]), do: 1
    def match(["C", "Y"]), do: 2

    # Draws
    def match(["A", "X"]), do: 4
    def match(["B", "Y"]), do: 5
    def match(["C", "Z"]), do: 6
  end

  defmodule Part2 do
    @moduledoc """
    AOC2022 Day 2 Part 2
    """

    @doc """
    Readme example part2

    ## Examples

        iex> Day02.Part2.example()
        12

    """
    def example() do
      Day02.parse("A Y\nB X\nC Z")
      |> score()
    end

    def score(input) do
      Enum.map(input, fn hands ->
        match(hands)
      end)
      |> Enum.sum()
    end

    # You Win
    def match(["A", "Z"]), do: 8
    def match(["B", "Z"]), do: 9
    def match(["C", "Z"]), do: 7

    # Opponent Wins
    def match(["A", "X"]), do: 3
    def match(["B", "X"]), do: 1
    def match(["C", "X"]), do: 2

    # Draws
    def match(["A", "Y"]), do: 4
    def match(["B", "Y"]), do: 5
    def match(["C", "Y"]), do: 6
  end

  def part1 do
    input()
    |> Part1.score()
  end

  def part2 do
    input()
    |> Part2.score()
  end
end
