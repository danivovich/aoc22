defmodule Day01 do
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

  defp next_acc({sum, max}, nil) when sum > max do
    {0, sum}
  end

  defp next_acc({_sum, max}, nil) do
    {0, max}
  end

  defp next_acc({sum, max}, n) do
    {sum + n, max}
  end

  def main do
    data = data()

    {_sum, max} =
      Enum.reduce(data, {0, 0}, fn n, acc ->
        next_acc(acc, n)
      end)

    IO.puts(max)
  end
end

Day01.main()
