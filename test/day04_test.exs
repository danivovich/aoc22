defmodule Day04Test do
  use ExUnit.Case
  doctest Day04
  doctest Day04.Part1
  doctest Day04.Part2

  test "checks part 1" do
    assert Day04.part1() == 580
  end

  # test "checks part 2" do
  # assert Day04.part2() == nil
  # end
end
