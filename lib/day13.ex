defmodule Day13 do
  @moduledoc """
  AOC2022 Day 13
  """

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

  @doc """
  Example Inputs for Part 2

  ## Examples

      iex> Day13.compare([1,1,3,1,1], [1,1,5,1,1])
      true
      iex> Day13.compare([[1],[2,3,4]], [[1],4])
      true
      iex> Day13.compare([9], [[8,7,6]])
      false
      iex> Day13.compare([[4,4],4,4], [[4,4],4,4,4])
      true
      iex> Day13.compare([7,7,7,7], [7,7,7])
      false
      iex> Day13.compare([], [3])
      true
      iex> Day13.compare([[[]]], [[]])
      false
      iex> Day13.compare([1,[2,[3,[4,[5,6,7]]]],8,9], [1,[2,[3,[4,[5,6,0]]]],8,9])
      false
      iex> Day13.compare([4], [3])
      false
      iex> Day13.compare([4, 4], [4, 3])
      false
      iex> Day13.compare([4, 2], [4, 3])
      true
      iex> Day13.compare([[],[],[9,7]], [[],[]])
      false
      iex> Day13.compare([[],[]], [[],[],[9,7]])
      true
  """
  def compare(left, right) when is_integer(left) and is_integer(right) do
    IO.inspect(left, label: "compare left int")
    IO.inspect(right, label: "compare right int")

    case left <= right do
      true ->
        IO.inspect("less than ok")
        true

      _ ->
        IO.inspect("NOT ok")
        false
    end
  end

  def compare(left, right) when is_integer(left) and is_list(right) do
    IO.inspect(left, label: "compare left int")
    IO.inspect(right, label: "compare right list")
    IO.inspect("wrap right and compare")
    compare([left], right)
  end

  def compare(left, right) when is_list(left) and is_integer(right) do
    IO.inspect(left, label: "compare left list")
    IO.inspect(right, label: "compare right int")
    IO.inspect("wrap right and compare")
    compare(left, [right])
  end

  def compare([], []) do
    IO.inspect([], label: "compare left empty")
    IO.inspect([], label: "compare right empty")
    IO.inspect("same size ok")
    true
  end

  def compare([], more) when is_list(more) do
    IO.inspect([], label: "compare left exhaust left")
    IO.inspect(more, label: "compare right exhaust left")
    IO.inspect("left out, ok")
    true
  end

  def compare(more, []) when is_list(more) do
    IO.inspect(more, label: "compare left exhaust right")
    IO.inspect([], label: "compare right exhaust right")
    IO.inspect("right out, NOT ok")
    false
  end

  def compare([left | first] = l, [right | second] = r)
      when is_integer(left) and is_integer(right) do
    IO.inspect(l, label: "compare left int first elm")
    IO.inspect(r, label: "compare right int first elm")

    case left < right do
      true ->
        IO.inspect("left smaller, ok")
        true

      false ->
        case left == right do
          true ->
            IO.inspect("equal keep going")
            true and compare(first, second)

          false ->
            IO.inspect("right smaller, NOT OK")
            false
        end
    end
  end

  def compare([left | first] = l, [right | second] = r)
      when is_list(left) and is_integer(right) do
    IO.inspect(l, label: "compare left list as first elm")
    IO.inspect(r, label: "compare right int as first elm")
    compare(left, [right]) and compare(first, second)
  end

  def compare([left | first] = l, [right | second] = r)
      when is_integer(left) and is_list(right) do
    IO.inspect(l, label: "compare left int as first elm")
    IO.inspect(r, label: "compare right list as first elm")
    compare([left], right) and compare(first, second)
  end

  def compare([left | first] = l, [right | second] = r) when is_list(left) and is_list(right) do
    IO.inspect(l, label: "compare left list as first elm")
    IO.inspect(r, label: "compare right list as first elm")
    compare(left, right) and compare(first, second)
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

        case Day13.compare(first, second) do
          true ->
            IO.puts("Good for #{i + 1}")
            i + 1

          false ->
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

  def part2 do
    Day13.input()
    nil
  end
end
