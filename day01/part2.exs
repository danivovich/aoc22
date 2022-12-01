defmodule Day01Part2 do
  defp parse(nil) do
    nil
  end

  defp parse("") do
    nil
  end

  defp parse(s) do
    {i, _} = Integer.parse(s)
    i
  end

  defp data do
    {:ok, contents} = File.read("input.txt")

    contents
    |> String.split("\n")
    |> Enum.map(fn s ->
      parse(s)
    end)
  end

  def main do
    data = data()

    {_sum, list} =
      Enum.reduce(data, {0, []}, fn n, acc ->
        {sum, list} = acc

        if n == nil do
          {0, [sum | list]}
        else
          {sum + n, list}
        end
      end)

    list
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
    |> IO.puts()
  end
end

Day01Part2.main()
