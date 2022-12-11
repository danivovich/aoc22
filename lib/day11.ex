defmodule Day11 do
  @moduledoc """
  AOC2022 Day 11
  """

  def input do
    {:ok, contents} = File.read("inputs/day11_input.txt")

    parseInput(contents)
  end

  def example do
    {:ok, contents} = File.read("inputs/day11_example.txt")

    parseInput(contents)
  end

  def parseInput(contents) do
    contents
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn monkeyDescription ->
      monkey = parseMonkey(monkeyDescription)
      {monkey[:num], monkey}
    end)
    |> Map.new()
  end

  def parseMonkey(description) do
    description
    |> String.split("\n", trim: true)
    |> Enum.map(fn monkeyLine ->
      parseLine(monkeyLine)
    end)
    |> Map.new()
    |> Map.put_new(:inspectionCount, 0)
  end

  def parseLine("Monkey " <> numString) do
    {num, _} =
      numString
      |> String.replace(":", "")
      |> Integer.parse()

    {:num, num}
  end

  def parseLine("  Starting items: " <> itemsString) do
    items =
      itemsString
      |> String.split(", ", trim: true)
      |> Enum.map(fn s ->
        {i, _} = Integer.parse(s)
        i
      end)

    {:items, items}
  end

  def parseLine("  Operation: " <> op), do: {:operation, op}
  def parseLine("  Test: " <> test), do: {:test, test}

  def parseLine("    If true: throw to monkey " <> numString) do
    {num, _} =
      numString
      |> String.replace(":", "")
      |> Integer.parse()

    {:trueToMonkey, num}
  end

  def parseLine("    If false: throw to monkey " <> numString) do
    {num, _} =
      numString
      |> String.replace(":", "")
      |> Integer.parse()

    {:falseToMonkey, num}
  end

  def worry(item, "new = old * old"), do: item * item

  def worry(item, "new = old * " <> v) do
    {i, _} = Integer.parse(v)
    i * item
  end

  def worry(item, "new = old + " <> v) do
    {i, _} = Integer.parse(v)
    i + item
  end

  def monkeyTest(item, "divisible by " <> v) do
    {i, _} = Integer.parse(v)
    rem(item, i) == 0
  end

  def toss(new, newItems, monkey, target, monkeys) do
    oldMonkey =
      monkey
      |> Map.put(:items, newItems)

    oldTargetMonkey = monkeys[target]

    newTargetMonkey =
      oldTargetMonkey
      |> Map.put(:items, Enum.concat(oldTargetMonkey[:items], [new]))

    monkeys
    |> Map.put(monkey[:num], oldMonkey)
    |> Map.put(target, newTargetMonkey)
  end

  def monkeyBusiness(monkeys) do
    [top1, top2] =
      monkeys
      |> Enum.map(fn {_i, monkey} ->
        monkey[:inspectionCount]
      end)
      |> Enum.sort()
      |> Enum.reverse()
      |> Enum.take(2)

    top1 * top2
  end

  defmodule Part1 do
    @doc """
    Example Inputs for Part 1

    ## Examples

        iex> Day11.Part1.example()
        10605

    """
    def example() do
      Day11.example()
      |> runRounds(20)
      |> Day11.monkeyBusiness()
    end

    def runRounds(monkeys, amount) do
      Range.new(1, amount)
      |> Enum.reduce(monkeys, fn _round, monkeys ->
        runRound(monkeys)
      end)
    end

    def runRound(monkeys) do
      Range.new(0, Enum.count(monkeys) - 1)
      |> Enum.reduce(monkeys, fn num, monkeys ->
        monkey = monkeys[num]
        items = monkey[:items]
        monkeyTurn(items, monkey, monkeys)
      end)
    end

    def monkeyTurn([], _monkey, monkeys), do: monkeys

    def monkeyTurn([item | items], monkey, monkeys) do
      newItemValue = Day11.worry(item, monkey[:operation])
      newMonkey = Map.put(monkey, :inspectionCount, monkey[:inspectionCount] + 1)
      newItemValue = bored(newItemValue)

      targetMonkey =
        case Day11.monkeyTest(newItemValue, monkey[:test]) do
          true ->
            monkey[:trueToMonkey]

          false ->
            monkey[:falseToMonkey]
        end

      newMonkeys = Day11.toss(newItemValue, items, newMonkey, targetMonkey, monkeys)
      monkeyTurn(items, newMonkey, newMonkeys)
    end

    def bored(item), do: floor(item / 3)
  end

  defmodule Part2 do
    @doc """
    Example Inputs for Part 2

    ## Examples

        iex> Day11.Part2.example()
        2713310158

    """
    def example() do
      Day11.example()
      |> runRounds(10_000)
      |> Day11.monkeyBusiness()
    end

    def runRounds(monkeys, amount) do
      lcm =
        Enum.reduce(monkeys, 1, fn {_k, monkey}, acc ->
          acc * divisor(monkey[:test])
        end)

      Range.new(1, amount)
      |> Enum.reduce(monkeys, fn _nround, monkeys ->
        runRound(monkeys, lcm)
      end)
    end

    def runRound(monkeys, lcm) do
      Range.new(0, Enum.count(monkeys) - 1)
      |> Enum.reduce(monkeys, fn num, monkeys ->
        monkey = monkeys[num]
        items = monkey[:items]
        monkeyTurn(items, monkey, monkeys, lcm)
      end)
    end

    def monkeyTurn([], _monkey, monkeys, _lcm), do: monkeys

    def monkeyTurn([item | items], monkey, monkeys, lcm) do
      newItemValue = Day11.worry(item, monkey[:operation])
      newMonkey = Map.put(monkey, :inspectionCount, monkey[:inspectionCount] + 1)
      newItemValue = bored(newItemValue, lcm)

      targetMonkey =
        case Day11.monkeyTest(newItemValue, monkey[:test]) do
          true ->
            monkey[:trueToMonkey]

          false ->
            monkey[:falseToMonkey]
        end

      newMonkeys = Day11.toss(newItemValue, items, newMonkey, targetMonkey, monkeys)
      monkeyTurn(items, newMonkey, newMonkeys, lcm)
    end

    def bored(item, lcm) do
      rem(item, lcm)
    end

    def divisor("divisible by " <> v) do
      {i, _} = Integer.parse(v)
      i
    end
  end

  def part1 do
    Day11.input()
    |> Day11.Part1.runRounds(20)
    |> Day11.monkeyBusiness()
  end

  def part2 do
    Day11.input()
    |> Day11.Part2.runRounds(10_000)
    |> Day11.monkeyBusiness()
  end
end
