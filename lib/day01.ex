defmodule Day01 do
  @moduledoc """
  AOC2022 Day 1
  """

  defp elfs do
    {:ok, contents} = File.read("inputs/day01_input.txt")

    contents
    |> String.split("\n\n")
    |> Enum.map(fn s ->
      String.split(s, "\n", trim: true)
      |> Enum.map(fn s ->
        {i, _} = Integer.parse(s)
        i
      end)
      |> Enum.sum()
    end)
  end

  def part1 do
    elfs()
    |> Enum.max()
  end

  def part2 do
    elfs()
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end
end
