defmodule Day02Test do
  use ExUnit.Case
  doctest Day02
  doctest Day02.Part1
  doctest Day02.Part2

  test "checks part 1" do
    assert Day02.part1() == 14375
  end

  test "checks part 2" do
    assert Day02.part2() == 10274
  end
end
