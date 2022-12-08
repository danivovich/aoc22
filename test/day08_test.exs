defmodule Day08Test do
  use ExUnit.Case
  doctest Day08
  doctest Day08.Part1
  doctest Day08.Part2

  test "checks part 1" do
    assert Day08.part1() == 1733
  end

  test "checks part 2" do
    assert Day08.part2() == 284_648
  end
end
