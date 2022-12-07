defmodule Day07 do
  @moduledoc """
  AOC2022 Day 7
  """

  def input do
    {:ok, contents} = File.read("inputs/day07_input.txt")

    contents
    |> String.split("\n", trim: true)
  end

  def example do
    {:ok, contents} = File.read("inputs/day07_example.txt")

    contents
    |> String.split("\n", trim: true)
  end

  def processListing(commands) do
    Enum.reduce(commands, %{in_list: false, cwd: []}, fn command, stats ->
      processCommand(command, stats)
    end)
    |> finalize()
  end

  defp finalize(stats) do
    depth = length(stats[:cwd])

    Range.new(0, depth - 2)
    |> Enum.reduce(stats, fn _left, stats ->
      processCommand("$ cd ..", stats)
    end)
  end

  def processCommand("$ cd /", stats) do
    stats
    |> Map.put(:cwd, ["/"])
    |> Map.put("/", 0)
  end

  def processCommand("$ ls", stats), do: stats

  def processCommand("$ cd ..", stats) do
    path = Enum.join(stats[:cwd], "/")
    folder_size = Map.get(stats, path)
    new_wd = Enum.take(stats[:cwd], length(stats[:cwd]) - 1)
    new_path = Enum.join(new_wd, "/")
    current_size = Map.get(stats, new_path)

    stats
    |> Map.put(:cwd, new_wd)
    |> Map.put(new_path, current_size + folder_size)
  end

  def processCommand("$ cd " <> dir, stats) do
    new_wd = Enum.concat(stats[:cwd], [dir])
    path = Enum.join(new_wd, "/")

    stats
    |> Map.put(:cwd, new_wd)
    |> Map.put(path, 0)
  end

  def processCommand("dir " <> _dir_name, stats), do: stats

  def processCommand(file, stats) do
    [size, _filename] = String.split(file, " ", trim: true)
    {fsize, _} = Integer.parse(size)
    path = Enum.join(stats[:cwd], "/")
    current_size = Map.get(stats, path)
    Map.put(stats, path, current_size + fsize)
  end

  defmodule Part1 do
    @doc """
    Example Inputs

    ## Examples

        iex> Day07.Part1.example()
        95437

    """
    def example() do
      Day07.example()
      |> Day07.processListing()
      |> Day07.Part1.calculate()
    end

    def calculate(stats) do
      stats
      |> total()
    end

    defp total(stats) do
      stats
      |> Enum.map(fn {k, v} ->
        value_for(k, v)
      end)
      |> Enum.sum()
    end

    def value_for(:cwd, _), do: 0
    def value_for(:in_list, _), do: 0

    def value_for(_k, v) do
      case v <= 100_000 do
        true ->
          v

        false ->
          0
      end
    end
  end

  defmodule Part2 do
    @doc """
    Example Inputs

    ## Examples

        iex> Day07.Part2.example()
        24933642

    """
    def example() do
      Day07.example()
      |> Day07.processListing()
      |> Day07.Part2.calculate()
    end

    def calculate(stats) do
      total = 70_000_000
      outer = stats["/"]
      target = 30_000_000
      free = total - outer
      need = target - free

      stats
      |> total(need)
    end

    defp total(stats, need) do
      stats
      |> Enum.map(fn {k, v} ->
        value_for(k, v, need)
      end)
      |> Enum.min()
    end

    def value_for(:cwd, _, _), do: nil
    def value_for(:in_list, _, _), do: nil

    def value_for(_k, v, need) do
      case v >= need do
        true ->
          v

        false ->
          nil
      end
    end
  end

  def part1 do
    input()
    |> Day07.processListing()
    |> Day07.Part1.calculate()
  end

  def part2 do
    input()
    |> Day07.processListing()
    |> Day07.Part2.calculate()
  end
end
