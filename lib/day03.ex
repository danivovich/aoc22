defmodule Day03 do
  @moduledoc """
  AOC2022 Day 3
  """

  def example do
    {:ok, contents} = File.read("inputs/day03_example.txt")
    contents
  end

  def input do
    {:ok, contents} = File.read("inputs/day03_input.txt")
    contents
  end

  def prioritize(item) do
    case(String.match?(item, ~r/[a-z]/)) do
      true ->
        :binary.first(item) - :binary.first("a") + 1

      false ->
        :binary.first(item) - :binary.first("A") + 27
    end
  end

  def score(input) do
    Enum.map(input, fn item ->
      prioritize(item)
    end)
    |> Enum.sum()
  end

  defmodule Part1 do
    @moduledoc """
    AOC2022 Day 3 Part 1
    """

    @doc """
    Parse input

    ## Examples

        iex> Day03.Part1.parseRucksacks(Day03.example())
        ["p", "L", "P", "v", "t", "s"]

    """
    def parseRucksacks(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn rucksack ->
        length = String.length(rucksack)
        half = Integer.floor_div(length, 2)

        first_sack =
          rucksack
          |> String.slice(0, half)
          |> String.split("", trim: true)
          |> MapSet.new()

        second_sack =
          rucksack
          |> String.slice(half, length)
          |> String.split("", trim: true)
          |> MapSet.new()

        [item_type] =
          first_sack
          |> MapSet.intersection(second_sack)
          |> MapSet.to_list()

        item_type
      end)
    end

    @doc """
    Readme example part1

    ## Examples

        iex> Day03.Part1.example()
        157

    """
    def example() do
      Day03.example()
      |> parseRucksacks()
      |> Day03.score()
    end
  end

  defmodule Part2 do
    @moduledoc """
    AOC2022 Day 3 Part 2
    """

    @doc """
    Parse input

    ## Examples

        iex> Day03.Part2.parseRucksacks(Day03.example())
        ["r", "Z"]

    """
    def parseRucksacks(input) do
      input
      |> String.split("\n", trim: true)
      |> Stream.chunk_every(3)
      |> Enum.to_list()
      |> Enum.map(fn group ->
        [sack1, sack2, sack3] = group

        first_sack =
          sack1
          |> String.split("", trim: true)
          |> MapSet.new()

        second_sack =
          sack2
          |> String.split("", trim: true)
          |> MapSet.new()

        third_sack =
          sack3
          |> String.split("", trim: true)
          |> MapSet.new()

        [item_type] =
          first_sack
          |> MapSet.intersection(second_sack)
          |> MapSet.intersection(third_sack)
          |> MapSet.to_list()

        item_type
      end)
    end

    @doc """
    Readme example part2

    ## Examples

        iex> Day03.Part2.example()
        70

    """
    def example() do
      Day03.example()
      |> parseRucksacks()
      |> Day03.score()
    end
  end

  def part1 do
    input()
    |> Part1.parseRucksacks()
    |> score()
  end

  def part2 do
    input()
    |> Part2.parseRucksacks()
    |> score()
  end
end
