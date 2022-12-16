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
  def compare(left, right) do
    case check_order(left, right) do
      :ok -> true
      :unknown -> true
      :wrong -> false
    end
  end

  defp check_order(left, right) do
    case {left, right} do
      {l, r} when is_integer(l) and is_integer(r) -> compare_ints(l, r)
      {l, r} when is_list(l) and is_list(r) -> compare_lists(l, r)
      {l, r} when is_integer(l) and is_list(r) -> check_order([l], r)
      {l, r} when is_list(l) and is_integer(r) -> check_order(l, [r])
    end
  end

  defp compare_ints(left, right) do
    cond do
      left < right -> :ok
      left > right -> :wrong
      left == right -> :unknown
    end
  end

  defp compare_lists(left, right) do
    cond do
      left == [] and right == [] -> :unknown
      left == [] -> :ok
      right == [] -> :wrong
      true -> compare_lists_by_element(left, right)
    end
  end

  defp compare_lists_by_element([left | restLeft], [right | restRight]) do
    order = check_order(left, right)

    case order do
      :unknown ->
        compare_lists(restLeft, restRight)

      _ ->
        order
    end
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
        case Day13.compare(first, second) do
          true ->
            i + 1

          false ->
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
      case Day13.compare(first, second) do
        true ->
          i + 1

        false ->
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
