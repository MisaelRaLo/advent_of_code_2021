defmodule DayTwoPartOne do
  @moduledoc """
    Day 2: Dive!
    Now, you need to figure out how to pilot this thing.

    It seems like the submarine can take a series of commands like forward 1, down 2, or up 3:

    forward X increases the horizontal position by X units.
    down X increases the depth by X units.
    up X decreases the depth by X units.
    Note that since you're on a submarine, down and up affect your depth, and so they have the opposite result of what you might expect.

    The submarine seems to already have a planned course (your puzzle input). You should probably figure out where it's going. For example:

    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
    Your horizontal position and depth both start at 0. The steps above would then modify them as follows:

    forward 5 adds 5 to your horizontal position, a total of 5.
    down 5 adds 5 to your depth, resulting in a value of 5.
    forward 8 adds 8 to your horizontal position, a total of 13.
    up 3 decreases your depth by 3, resulting in a value of 2.
    down 8 adds 8 to your depth, resulting in a value of 10.
    forward 2 adds 2 to your horizontal position, a total of 15.
    After following these instructions, you would have a horizontal position of 15 and a depth of 10. (Multiplying these together produces 150.)

    Calculate the horizontal position and depth you would have after following the planned course. What do you get if you multiply your final horizontal position by your final depth?

  """

  @type horizontal_position :: integer()
  @type depth :: integer()
  @type coordinates :: {horizontal_position, depth}
  @type planned_course :: integer()

  @spec perform(binary) :: planned_course
  def perform(input) do
    h_pos = depth = 0
    initial_coordinates = {h_pos, depth}

    input
    |> parse_input()
    |> Enum.reduce(initial_coordinates, &calculate_movement/2)
    |> multiply_quantities()
  end

  @spec parse_input(binary) :: list
  def parse_input(input) do
    input
    |> String.splitter("\n")
    |> Enum.to_list()
  end

  @spec calculate_movement(binary, coordinates) :: coordinates
  def calculate_movement(_commands = "forward" <> " " <> value, _coordinates = {h_pos, depth}) do
    h_pos = h_pos + String.to_integer(value)
    coordinates = {h_pos, depth}
    coordinates
  end

  def calculate_movement(_commands = "down" <> " " <> value, _coordinates = {h_pos, depth}) do
    depth = depth + String.to_integer(value)
    coordinates = {h_pos, depth}
    coordinates
  end

  def calculate_movement(_commands = "up" <> " " <> value, _coordinates = {h_pos, depth}) do
    depth = depth - String.to_integer(value)
    coordinates = {h_pos, depth}
    coordinates
  end

  def calculate_movement(_commands = "", coordinates), do: coordinates

  @spec multiply_quantities(coordinates) :: planned_course
  def multiply_quantities(_coordinates = {h_pos, depth}), do: h_pos * depth
end
