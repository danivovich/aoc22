defmodule Day01Part2 do
  defp parse(s) do
    case Integer.parse(s) do
      {i, _} ->
        i

      _ ->
        nil
    end
  end

  defp data do
    {:ok, contents} = File.read("input.txt")

    contents
    |> String.split("\n")
    |> Enum.map(fn s ->
      parse(s)
    end)
  end

  defp next_acc({sum, list}, nil) do
    {0, [sum | list]}
  end

  defp next_acc({sum, list}, n) do
    {sum + n, list}
  end

  def main do
    data = data()

    {_sum, list} =
      Enum.reduce(data, {0, []}, fn n, acc ->
        next_acc(acc, n)
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
