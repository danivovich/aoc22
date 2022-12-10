defmodule Day10Test do
  use ExUnit.Case
  doctest Day10
  doctest Day10.Part1
  doctest Day10.Part2

  test "checks part 1" do
    assert Day10.part1() == 12540
  end

  test "checks part 2" do
    assert Day10.part2() == [
             "####.####..##..####.####.#....#..#.####.",
             "#....#....#..#....#.#....#....#..#.#....",
             "###..###..#......#..###..#....####.###..",
             "#....#....#.....#...#....#....#..#.#....",
             "#....#....#..#.#....#....#....#..#.#....",
             "#....####..##..####.####.####.#..#.####.",
             "."
           ]
  end
end
