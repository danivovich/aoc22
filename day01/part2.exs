defmodule Day01Part2 do
  defp elfs do
    {:ok, contents} = File.read("input.txt")

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

  def main do
    elfs()
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
    |> IO.puts()
  end
end

Day01Part2.main()
