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

  @doc """
  Readme example part1

  ## Examples

      iex> Day02.examplepart1()
      15

  """
  def examplepart1() do
    Day02.parse("A Y\nB X\nC Z")
    |> Day02.scorepart1()
  end

  def scorepart1(input) do
    Enum.map(input, fn hands ->
      matchp1(hands)
    end)
    |> Enum.sum()
  end

  # You Win
  def matchp1(["A", "Y"]), do: 8
  def matchp1(["B", "Z"]), do: 9
  def matchp1(["C", "X"]), do: 7

  # Opponent Wins
  def matchp1(["A", "Z"]), do: 3
  def matchp1(["B", "X"]), do: 1
  def matchp1(["C", "Y"]), do: 2

  # Draws
  def matchp1(["A", "X"]), do: 4
  def matchp1(["B", "Y"]), do: 5
  def matchp1(["C", "Z"]), do: 6

  def part1 do
    input()
    |> scorepart1()
  end

  @doc """
  Readme example part2

  ## Examples

      iex> Day02.examplepart2()
      12

  """
  def examplepart2() do
    Day02.parse("A Y\nB X\nC Z")
    |> Day02.scorepart2()
  end

  def scorepart2(input) do
    Enum.map(input, fn hands ->
      matchp2(hands)
    end)
    |> Enum.sum()
  end

  # You Win
  def matchp2(["A", "Z"]), do: 8
  def matchp2(["B", "Z"]), do: 9
  def matchp2(["C", "Z"]), do: 7

  # Opponent Wins
  def matchp2(["A", "X"]), do: 3
  def matchp2(["B", "X"]), do: 1
  def matchp2(["C", "X"]), do: 2

  # Draws
  def matchp2(["A", "Y"]), do: 4
  def matchp2(["B", "Y"]), do: 5
  def matchp2(["C", "Y"]), do: 6

  def part2 do
    input()
    |> scorepart2()
  end
end
