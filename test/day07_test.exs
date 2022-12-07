defmodule Day07Test do
  use ExUnit.Case
  doctest Day07
  doctest Day07.Part1
  doctest Day07.Part2

  test "checks part 1" do
    assert Day07.part1() == 1_491_614
  end

  test "checks part 2" do
    assert Day07.part2() == 6_400_111
  end
end
