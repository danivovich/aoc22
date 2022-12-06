defmodule Day06 do
  @moduledoc """
  AOC2022 Day 6
  """

  def input do
    {:ok, contents} = File.read("inputs/day06_input.txt")
    contents
  end

  def parse(input) do
    input
  end

  defmodule Part1 do
    @doc """
    Example Inputs

    ## Examples

        iex> Day06.Part1.example("mjqjpqmgbljsphdztnvjfqwrcgsmlb")
        7
        iex> Day06.Part1.example("bvwbjplbgvbhsrlpgdmjqwftvncz")
        5
        iex> Day06.Part1.example("nppdvjthqldpwncqszvftbrmjlhg")
        6
        iex> Day06.Part1.example("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
        10
        iex> Day06.Part1.example("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
        11

    """
    def example(input) do
      input
      |> String.split("", trim: true)
      |> findPacketMarker(1)
    end

    def findPacketMarker(values, index) do
      {four, rest} = Enum.split(values, 4)
      {_first, three} = Enum.split(four, 1)
      findPacketMarker(four, Enum.concat(three, rest), index)
    end

    def findPacketMarker(_four, [], _index), do: nil

    def findPacketMarker(four, rest, index) do
      case Enum.uniq(four) == four do
        true ->
          index + 3

        _ ->
          {four, next_rest} = Enum.split(rest, 4)
          {_first, three} = Enum.split(four, 1)
          findPacketMarker(four, Enum.concat(three, next_rest), index + 1)
      end
    end
  end

  defmodule Part2 do
    @doc """
    Example Inputs

    ## Examples

        iex> Day06.Part2.example("mjqjpqmgbljsphdztnvjfqwrcgsmlb")
        19
        iex> Day06.Part2.example("bvwbjplbgvbhsrlpgdmjqwftvncz")
        23
        iex> Day06.Part2.example("nppdvjthqldpwncqszvftbrmjlhg")
        23
        iex> Day06.Part2.example("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
        29
        iex> Day06.Part2.example("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
        26

    """
    def example(input) do
      input
      |> String.split("", trim: true)
      |> findPacketMarker(1)
    end

    def findPacketMarker(values, index) do
      {fourteen, rest} = Enum.split(values, 14)
      {_first, thirteen} = Enum.split(fourteen, 1)
      findPacketMarker(fourteen, Enum.concat(thirteen, rest), index)
    end

    def findPacketMarker(_four, [], _index), do: nil

    def findPacketMarker(fourteen, rest, index) do
      case Enum.uniq(fourteen) == fourteen do
        true ->
          index + 13

        _ ->
          {fourteen, next_rest} = Enum.split(rest, 14)
          {_first, thirteen} = Enum.split(fourteen, 1)
          findPacketMarker(fourteen, Enum.concat(thirteen, next_rest), index + 1)
      end
    end
  end

  def part1 do
    Day06.input()
    |> String.split("", trim: true)
    |> Day06.Part1.findPacketMarker(1)
  end

  def part2 do
    Day06.input()
    |> String.split("", trim: true)
    |> Day06.Part2.findPacketMarker(1)
  end
end
