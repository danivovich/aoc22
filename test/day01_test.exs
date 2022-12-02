defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "checks part 1" do
    assert Day01.part1() == 67622
  end

  test "checks part 2" do
    assert Day01.part2() == 201_491
  end
end
