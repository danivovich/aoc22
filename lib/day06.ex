defmodule Day06 do
  @moduledoc """
  AOC2022 Day 6
  """

  def input do
    {:ok, contents} = File.read("inputs/day06_input.txt")
    contents
  end

  def findPacketMarker(values, size \\ 14, index \\ 1) do
    {packet, message} = Enum.split(values, size)
    {_first, remain} = Enum.split(packet, 1)
    findPacketMarker(packet, size, Enum.concat(remain, message), index)
  end

  def findPacketMarker(_packet, _size, [], _index), do: nil

  def findPacketMarker(packet, size, message, index) do
    case Enum.uniq(packet) == packet do
      true ->
        index + size - 1

      _ ->
        {packet, message} = Enum.split(message, size)
        {_first, remain} = Enum.split(packet, 1)
        findPacketMarker(packet, size, Enum.concat(remain, message), index + 1)
    end
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
      |> Day06.findPacketMarker(4)
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
      |> Day06.findPacketMarker(14)
    end
  end

  def part1 do
    input()
    |> String.split("", trim: true)
    |> findPacketMarker(4)
  end

  def part2 do
    input()
    |> String.split("", trim: true)
    |> findPacketMarker(14)
  end
end
