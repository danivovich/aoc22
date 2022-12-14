defmodule Day13 do
  @moduledoc """
  AOC2022 Day 13
  """

  defexception message: "match issue"

  def input do
    {:ok, contents} = File.read("inputs/day13_input.txt")

    parseInput(contents)
  end

  def example do
    {:ok, contents} = File.read("inputs/day13_example.txt")

    parseInput(contents)
  end

  def parseInput(contents) do
    contents
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn pair ->
      pair
      |> String.split("\n", trim: true)
      |> Enum.map(fn list ->
        Jason.decode!(list)
      end)
    end)
  end

  def compare(left, right) when is_integer(left) and is_integer(right) do
    IO.inspect(left, label: "compare left")
    IO.inspect(right, label: "compare right")

    case left <= right do
      true ->
        IO.inspect("less than ok")
        true

      _ ->
        IO.inspect("NOT ok")
        raise Day13
    end
  end

  def compare(left, right) when is_integer(left) and is_list(right) do
    IO.inspect(left, label: "compare left")
    IO.inspect(right, label: "compare right")
    IO.inspect("wrap right and compare")
    compare([left], right)
  end

  def compare(left, right) when is_list(left) and is_integer(right) do
    IO.inspect(left, label: "compare left")
    IO.inspect(right, label: "compare right")
    IO.inspect("wrap right and compare")
    compare(left, [right])
  end

  def compare([], []) do
    IO.inspect([], label: "compare left")
    IO.inspect([], label: "compare right")
    IO.inspect("same size ok")
    true
  end

  def compare([], more) when is_list(more) do
    IO.inspect([], label: "compare left")
    IO.inspect(more, label: "compare right")
    IO.inspect("left out, ok")
    true
  end

  def compare(more, []) when is_list(more) do
    IO.inspect(more, label: "compare left")
    IO.inspect([], label: "compare right")
    IO.inspect("right out, NOT ok")
    raise Day13
  end

  def compare([left | first] = l, [right | second] = r)
      when is_integer(left) and is_integer(right) do
    IO.inspect(l, label: "compare left")
    IO.inspect(r, label: "compare right")

    case left < right do
      true ->
        IO.inspect("left smaller, ok")
        true

      false ->
        case left == right do
          true ->
            IO.inspect("equal keep going")
            compare(first, second)
            true

          false ->
            IO.inspect("right bigger, NOT OK")
            raise Day13
        end
    end
  end

  def compare([left | first] = l, [right | second] = r) do
    IO.inspect(l, label: "compare left")
    IO.inspect(r, label: "compare right")
    compare(left, right)
    compare(first, second)
  end

  defmodule Part1 do
    @doc """
    Example Inputs for Part 1

    ## Examples

        iex> Day13.Part1.example()
        13

    """
    def example() do
      Day13.example()
      |> Enum.with_index()
      |> Enum.map(fn {[first, second], i} ->
        IO.puts("\n\nStarting for #{i + 1}")

        try do
          Day13.compare(first, second)
          IO.puts("Good for #{i + 1}")
          i + 1
        rescue
          Day13 ->
            IO.puts("Bad for #{i + 1}")
            0
        end
      end)
      |> Enum.sum()
    end
  end

  defmodule Part2 do
    @doc """
    Example Inputs for Part 2

    ## Examples

        iex> Day13.Part2.example()
        nil

    """
    def example() do
      Day13.example()
      nil
    end
  end

  def part1 do
    Day13.input()
    nil
  end

  def part2 do
    Day13.input()
    nil
  end
end
