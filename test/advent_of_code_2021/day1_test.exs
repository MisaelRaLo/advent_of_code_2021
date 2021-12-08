defmodule DayOneTest do
  use ExUnit.Case, async: false

  alias DayOne

  @valid_input """
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
  """

  describe "day one - part 1" do
    @measurements_tagged [
      {199, :na},
      {200, :increased},
      {208, :increased},
      {210, :increased},
      {200, :decreased},
      {207, :increased},
      {240, :increased},
      {269, :increased},
      {260, :decreased},
      {263, :increased}
    ]

    test "perform_part_one/1" do
      assert DayOne.perform_part_one(@valid_input) == 7
    end

    test "parse_input/1" do
      assert DayOne.parse_input(@valid_input) == [
               199,
               200,
               208,
               210,
               200,
               207,
               240,
               269,
               260,
               263
             ]
    end

    test "compare_and_tag_measurements/1" do
      input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
      acc = []
      assert DayOne.compare_and_tag_measurements(input, acc, -1) == @measurements_tagged
    end

    test "compare_and_tag_measurements/1 w/some measurements that doesn't change" do
      input = [199, 200, 208, 210, 200, 207, 207, 269, 269, 260, 263]

      expected = [
        {199, :na},
        {200, :increased},
        {208, :increased},
        {210, :increased},
        {200, :decreased},
        {207, :increased},
        {207, :no_change},
        {269, :increased},
        {269, :no_change},
        {260, :decreased},
        {263, :increased}
      ]

      acc = []
      assert DayOne.compare_and_tag_measurements(input, acc, -1) == expected
      assert DayOne.count_increased(expected) == 6
    end

    test "count_increased/1" do
      assert DayOne.count_increased(@measurements_tagged) == 7
    end
  end

  describe "day one - part 2" do
    test "perform_part_two/1" do
      assert DayOne.perform_part_two(@valid_input) == 5
    end

    test "group_measurements/2" do
      list = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
      groups = [607, 618, 618, 617, 647, 716, 769, 792]

      assert DayOne.group_measurements(list, []) == groups
    end
  end
end
