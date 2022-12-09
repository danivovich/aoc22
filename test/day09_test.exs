defmodule Day09Test do
  use ExUnit.Case
  doctest Day09
  doctest Day09.Part1
  doctest Day09.Part2

  test "checks part 1" do
    assert Day09.part1() == 6175
  end

  test "checks part 2" do
    assert Day09.part2() == nil
  end
end
