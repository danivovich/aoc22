defmodule Day12Test do
  use ExUnit.Case
  doctest Day12
  doctest Day12.Part1
  doctest Day12.Part2

  test "checks part 1" do
    assert Day12.part1() == 534
  end

  test "checks part 2" do
    assert Day12.part2() == nil
  end
end
