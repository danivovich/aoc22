defmodule Day01 do
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

    {_sum, max} =
      Enum.reduce(data, {0, 0}, fn n, acc ->
        {sum, max} = acc

        if n == nil do
          if sum > max do
            {0, sum}
          else
            {0, max}
          end
        else
          {sum + n, max}
        end
      end)

    IO.puts(max)
  end
end

Day01.main()
