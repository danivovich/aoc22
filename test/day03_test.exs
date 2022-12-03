defmodule Day03Test do
  use ExUnit.Case
  doctest Day03
  doctest Day03.Part1
  doctest Day03.Part2

  test "checks part 1" do
    assert Day03.part1() == 8394
  end

  test "checks part 2" do
    assert Day03.part2() == nil
  end
end
