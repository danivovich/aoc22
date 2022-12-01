defmodule Day01 do
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
    |> Enum.max()
    |> IO.puts()
  end
end

Day01.main()
