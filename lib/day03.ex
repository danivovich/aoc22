defmodule Day03 do
  @moduledoc """
  AOC2022 Day 3
  """

  @doc """
  Parse input

  ## Examples

      iex> Day03.parseRucksacks(Day03.example())
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

  def example do
    {:ok, contents} = File.read("inputs/day03_example.txt")
    contents
  end

  def input do
    {:ok, contents} = File.read("inputs/day03_input.txt")
    contents
  end

  defmodule Part1 do
    @moduledoc """
    AOC2022 Day 3 Part 1
    """

    @doc """
    Readme example part1

    ## Examples

        iex> Day03.Part1.example()
        157

    """
    def example() do
      Day03.example()
      |> Day03.parseRucksacks()
      |> score()
    end

    def score(input) do
      Enum.map(input, fn item ->
        prioritize(item)
      end)
      |> Enum.sum()
    end

    def prioritize(item) do
      case(String.match?(item, ~r/[a-z]/)) do
        true ->
          :binary.first(item) - :binary.first("a") + 1

        false ->
          :binary.first(item) - :binary.first("A") + 27
      end
    end
  end

  defmodule Part2 do
    @moduledoc """
    AOC2022 Day 3 Part 2
    """
  end

  def part1 do
    input()
    |> parseRucksacks()
    |> Part1.score()
  end

  def part2 do
  end
end
