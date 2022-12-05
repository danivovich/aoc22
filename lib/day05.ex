defmodule Day05 do
  @moduledoc """
  AOC2022 Day 5
  """

  def example do
    {:ok, contents} = File.read("inputs/day05_example.txt")
    {contents, 3}
  end

  def input do
    {:ok, contents} = File.read("inputs/day05_input.txt")
    {contents, 9}
  end

  def parse({input, stack_count}) do
    [drawing, movements] =
      input
      |> String.split("\n\n", trim: true)

    init_stacks =
      Range.new(0, stack_count)
      |> Enum.map(fn _i -> [] end)

    stacks =
      drawing
      |> String.split("\n", trim: true)
      |> Enum.reduce(init_stacks, fn s, stacks ->
        updateStacksByRow(s, String.length(s), stacks)
      end)

    moves =
      movements
      |> String.split("\n", trim: true)

    %{moves: moves, stacks: stacks}
  end

  defp updateStacksByRow(s, 3, stacks) do
    %{"one" => one} = Regex.named_captures(~r/(?<one>[ \w\W]{3})/, s)

    stacks
    |> updateStack(1, one)
  end

  defp updateStacksByRow(s, 7, stacks) do
    %{"one" => one, "two" => two} =
      Regex.named_captures(~r/(?<one>[ \w\W]{3}) (?<two>[ \w\W]{3})/, s)

    stacks
    |> updateStack(1, one)
    |> updateStack(2, two)
  end

  defp updateStacksByRow(s, 11, stacks) do
    %{"one" => one, "two" => two, "three" => three} =
      Regex.named_captures(~r/(?<one>[ \w\W]{3}) (?<two>[ \w\W]{3}) (?<three>[ \w\W]{3})/, s)

    stacks
    |> updateStack(1, one)
    |> updateStack(2, two)
    |> updateStack(3, three)
  end

  defp updateStacksByRow(s, 15, stacks) do
    %{"one" => one, "two" => two, "three" => three, "four" => four} =
      Regex.named_captures(
        ~r/(?<one>[ \w\W]{3}) (?<two>[ \w\W]{3}) (?<three>[ \w\W]{3}) (?<four>[ \w\W]{3})/,
        s
      )

    stacks
    |> updateStack(1, one)
    |> updateStack(2, two)
    |> updateStack(3, three)
    |> updateStack(4, four)
  end

  defp updateStacksByRow(s, 19, stacks) do
    %{"one" => one, "two" => two, "three" => three, "four" => four, "five" => five} =
      Regex.named_captures(
        ~r/(?<one>[ \w\W]{3}) (?<two>[ \w\W]{3}) (?<three>[ \w\W]{3}) (?<four>[ \w\W]{3}) (?<five>[ \w\W]{3})/,
        s
      )

    stacks
    |> updateStack(1, one)
    |> updateStack(2, two)
    |> updateStack(3, three)
    |> updateStack(4, four)
    |> updateStack(5, five)
  end

  defp updateStacksByRow(s, 23, stacks) do
    %{"one" => one, "two" => two, "three" => three, "four" => four, "five" => five, "six" => six} =
      Regex.named_captures(
        ~r/(?<one>[ \w\W]{3}) (?<two>[ \w\W]{3}) (?<three>[ \w\W]{3}) (?<four>[ \w\W]{3}) (?<five>[ \w\W]{3}) (?<six>[ \w\W]{3})/,
        s
      )

    stacks
    |> updateStack(1, one)
    |> updateStack(2, two)
    |> updateStack(3, three)
    |> updateStack(4, four)
    |> updateStack(5, five)
    |> updateStack(6, six)
  end

  defp updateStacksByRow(s, 27, stacks) do
    %{
      "one" => one,
      "two" => two,
      "three" => three,
      "four" => four,
      "five" => five,
      "six" => six,
      "seven" => seven
    } =
      Regex.named_captures(
        ~r/(?<one>[ \w\W]{3}) (?<two>[ \w\W]{3}) (?<three>[ \w\W]{3}) (?<four>[ \w\W]{3}) (?<five>[ \w\W]{3}) (?<six>[ \w\W]{3}) (?<seven>[ \w\W]{3})/,
        s
      )

    stacks
    |> updateStack(1, one)
    |> updateStack(2, two)
    |> updateStack(3, three)
    |> updateStack(4, four)
    |> updateStack(5, five)
    |> updateStack(6, six)
    |> updateStack(7, seven)
  end

  defp updateStacksByRow(s, 31, stacks) do
    %{
      "one" => one,
      "two" => two,
      "three" => three,
      "four" => four,
      "five" => five,
      "six" => six,
      "seven" => seven,
      "eight" => eight
    } =
      Regex.named_captures(
        ~r/(?<one>[ \w\W]{3}) (?<two>[ \w\W]{3}) (?<three>[ \w\W]{3}) (?<four>[ \w\W]{3}) (?<five>[ \w\W]{3}) (?<six>[ \w\W]{3}) (?<seven>[ \w\W]{3}) (?<eight>[ \w\W]{3})/,
        s
      )

    stacks
    |> updateStack(1, one)
    |> updateStack(2, two)
    |> updateStack(3, three)
    |> updateStack(4, four)
    |> updateStack(5, five)
    |> updateStack(6, six)
    |> updateStack(7, seven)
    |> updateStack(8, eight)
  end

  defp updateStacksByRow(s, 35, stacks) do
    %{
      "one" => one,
      "two" => two,
      "three" => three,
      "four" => four,
      "five" => five,
      "six" => six,
      "seven" => seven,
      "eight" => eight,
      "nine" => nine
    } =
      Regex.named_captures(
        ~r/(?<one>[ \w\W]{3}) (?<two>[ \w\W]{3}) (?<three>[ \w\W]{3}) (?<four>[ \w\W]{3}) (?<five>[ \w\W]{3}) (?<six>[ \w\W]{3}) (?<seven>[ \w\W]{3}) (?<eight>[ \w\W]{3}) (?<nine>[ \w\W]{3})/,
        s
      )

    stacks
    |> updateStack(1, one)
    |> updateStack(2, two)
    |> updateStack(3, three)
    |> updateStack(4, four)
    |> updateStack(5, five)
    |> updateStack(6, six)
    |> updateStack(7, seven)
    |> updateStack(8, eight)
    |> updateStack(9, nine)
  end

  defp updateStacksByRow(_s, _l, stacks) do
    # ignore the last line
    stacks
  end

  def updateStack(stacks, stack_id, value) do
    case clean(value) do
      nil ->
        stacks

      v ->
        new_stack =
          stacks
          |> Enum.at(stack_id, [])
          |> List.insert_at(0, v)

        List.replace_at(stacks, stack_id, new_stack)
    end
  end

  defp clean("   "), do: nil

  defp clean(s) do
    Regex.replace(~r/[\[\]]/, s, "")
  end

  defmodule Part1 do
    @doc """
    Parse input

    ## Examples

        iex> Day05.Part1.example()
        "CMZ"

    """
    def example do
      Day05.example()
      |> Day05.parse()
      |> rearrange()
      |> resolve()
    end

    def resolve(stacks) do
      stacks
      |> Enum.map(fn stack ->
        Enum.at(stack, -1)
      end)
      |> Enum.join()
    end

    def rearrange(data) do
      data[:moves]
      |> Enum.reduce(data[:stacks], fn move, stacks ->
        move
        |> translateMove()
        |> applyMove(stacks)
      end)
    end

    defp translateMove(move) do
      %{"count" => c, "source" => s, "dest" => d} =
        Regex.named_captures(~r/move (?<count>\d+) from (?<source>\d+) to (?<dest>\d+)/, move)

      {count, _} = Integer.parse(c)
      {source, _} = Integer.parse(s)
      {dest, _} = Integer.parse(d)
      {source, dest, count}
    end

    defp applyMove({source_id, dest_id, count}, stacks) do
      source_stack = Enum.at(stacks, source_id)
      dest_stack = Enum.at(stacks, dest_id)
      left = Enum.take(source_stack, length(source_stack) - count)
      moving = Enum.take(source_stack, -1 * count) |> Enum.reverse()

      stacks
      |> List.replace_at(source_id, left)
      |> List.replace_at(dest_id, Enum.concat(dest_stack, moving))
    end
  end

  defmodule Part2 do
  end

  def part1 do
    Day05.input()
    |> Day05.parse()
    |> Day05.Part1.rearrange()
    |> Day05.Part1.resolve()
  end
end
