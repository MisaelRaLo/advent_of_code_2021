defmodule DayTwoTest do
  use ExUnit.Case, async: false

  alias DayTwoPartOne

  @valid_input """
  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2
  """

  describe "day two - part 1" do
    test "perform/1" do
      assert DayTwoPartOne.perform(@valid_input) == 150
    end

    test "parse_input/1" do
      assert DayTwoPartOne.parse_input(@valid_input) == [
               "forward 5",
               "down 5",
               "forward 8",
               "up 3",
               "down 8",
               "forward 2",
               ""
             ]
    end

    test "calculate_movement/2" do
      h_pos = 0
      depth = 0

      initial_coordinates = {h_pos, depth}
      forward_command = "forward 5"
      down_command = "down 8"
      up_command = "up 3"
      empty_command = ""

      assert DayTwoPartOne.calculate_movement(forward_command, initial_coordinates) == {5, 0}
      assert DayTwoPartOne.calculate_movement(down_command, initial_coordinates) == {0, 8}
      assert DayTwoPartOne.calculate_movement(up_command, initial_coordinates) == {0, -3}
      assert DayTwoPartOne.calculate_movement(empty_command, initial_coordinates) == {0, 0}
    end

    test "multiply_quantities/1" do
      h_pos = 15
      depth = 70

      initial_coordinates = {h_pos, depth}

      assert DayTwoPartOne.multiply_quantities(initial_coordinates) == 1050
    end
  end

  describe "day two - part 2" do
    alias DayTwoPartTwo
    test "perform/1" do
      assert DayTwoPartTwo.perform(@valid_input) == 900
    end
  end
end
