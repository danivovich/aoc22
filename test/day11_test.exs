defmodule Day11Test do
  use ExUnit.Case
  doctest Day11
  doctest Day11.Part1
  doctest Day11.Part2

  test "checks part 1" do
    assert Day11.part1() == 117_624
  end

  test "checks part 2" do
    assert Day11.part2() == nil
  end
end
