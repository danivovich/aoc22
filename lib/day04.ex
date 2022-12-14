defmodule Day04 do
  @moduledoc """
  AOC2022 Day 4
  """

  def example do
    {:ok, contents} = File.read("inputs/day04_example.txt")
    contents
  end

  def input do
    {:ok, contents} = File.read("inputs/day04_input.txt")
    contents
  end

  @doc """
  Parse input

  ## Examples

      iex> Day04.parseAssignments(Day04.example())
      [{2..4, 6..8}, {2..3, 4..5}, {5..7, 7..9}, {2..8, 3..7}, {6..6, 4..6}, {2..6, 4..8}]

  """
  def parseAssignments(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn pair ->
      [first, second] = String.split(pair, ",", trim: true)
      {range(first), range(second)}
    end)
  end

  defp range(input) do
    [start, stop] =
      input
      |> String.split("-", trim: true)
      |> Enum.map(fn string ->
        {i, _} = Integer.parse(string)
        i
      end)

    Range.new(start, stop)
  end

  defmodule Part1 do
    @moduledoc """
    AOC2022 Day 4 Part 1
    """

    def score(assignments) do
      Enum.map(assignments, fn {first, second} ->
        f =
          first
          |> Enum.to_list()
          |> MapSet.new()

        s =
          second
          |> Enum.to_list()
          |> MapSet.new()

        case f == s do
          true ->
            1

          false ->
            score(f, s) + score(s, f)
        end
      end)
      |> Enum.sum()
    end

    defp score(first, second) do
      case MapSet.intersection(first, second) == first do
        true ->
          1

        false ->
          0
      end
    end

    @doc """
    Readme example part1

    ## Examples

        iex> Day04.Part1.example()
        2

    """
    def example() do
      Day04.example()
      |> Day04.parseAssignments()
      |> Day04.Part1.score()
    end
  end

  defmodule Part2 do
    @moduledoc """
    AOC2022 Day 3 Part 2
    """

    @doc """
    Readme example part2

    ## Examples

        iex> Day04.Part2.example()
        4

    """
    def example() do
      Day04.example()
      |> Day04.parseAssignments()
      |> Day04.Part2.score()
    end

    def score(assignments) do
      Enum.map(assignments, fn {first, second} ->
        f =
          first
          |> Enum.to_list()
          |> MapSet.new()

        s =
          second
          |> Enum.to_list()
          |> MapSet.new()

        case MapSet.size(MapSet.intersection(f, s)) do
          0 ->
            0

          _ ->
            1
        end
      end)
      |> Enum.sum()
    end
  end

  def part1 do
    input()
    |> Day04.parseAssignments()
    |> Day04.Part1.score()
  end

  def part2 do
    input()
    |> Day04.parseAssignments()
    |> Day04.Part2.score()
  end
end
