defmodule Day05Test do
  use ExUnit.Case
  doctest Day05
  doctest Day05.Part1
  # doctest Day05.Part2

  test "checks part 1" do
    assert Day05.part1() == "ZWHVFWQWW"
  end

  # test "checks part 2" do
  # assert Day05.part2() == nil
  # end
end
