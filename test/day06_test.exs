defmodule Day06Test do
  use ExUnit.Case
  doctest Day06
  doctest Day06.Part1
  doctest Day06.Part2

  test "checks part 1" do
    assert Day06.part1() == 1965
  end

  test "checks part 2" do
    assert Day06.part2() == 2773
  end
end
