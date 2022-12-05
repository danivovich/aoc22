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
        updateStacksByRow(s, stack_count, stacks)
      end)

    moves =
      movements
      |> String.split("\n", trim: true)

    %{moves: moves, stacks: stacks}
  end

  defp updateStacksByRow(s, positions, stacks) do
    Range.new(1, positions)
    |> Enum.reduce(stacks, fn position, stacks ->
      index = position * 4 - 2
      crate = String.at(s, index - 1)
      updateStack(stacks, position, crate)
    end)
  end

  def updateStack(stacks, _stack_id, " "), do: stacks

  def updateStack(stacks, stack_id, value) do
    new_stack =
      stacks
      |> Enum.at(stack_id, [])
      |> List.insert_at(0, value)

    List.replace_at(stacks, stack_id, new_stack)
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
