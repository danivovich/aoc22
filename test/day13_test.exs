defmodule Day13Test do
  use ExUnit.Case
  doctest Day13
  doctest Day13.Part1
  doctest Day13.Part2

  test "checks part 1" do
    assert Day13.part1() == 4894
  end

  test "checks part 2" do
    assert Day13.part2() == 24180
  end
end
