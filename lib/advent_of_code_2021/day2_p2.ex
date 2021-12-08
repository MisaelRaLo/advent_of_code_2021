defmodule DayTwoPartTwo do
  @moduledoc """
    Part Two ---
    Based on your calculations, the planned course doesn't seem to make any sense. You find the submarine manual and discover that the process is actually slightly more complicated.

    In addition to horizontal position and depth, you'll also need to track a third value, aim, which also starts at 0. The commands also mean something entirely different than you first thought:

    down X increases your aim by X units.
    up X decreases your aim by X units.
    forward X does two things:
    It increases your horizontal position by X units.
    It increases your depth by your aim multiplied by X.
    Again note that since you're on a submarine, down and up do the opposite of what you might expect: "down" means aiming in the positive direction.

    Now, the above example does something different:

    forward 5 adds 5 to your horizontal position, a total of 5. Because your aim is 0, your depth does not change.
    down 5 adds 5 to your aim, resulting in a value of 5.
    forward 8 adds 8 to your horizontal position, a total of 13. Because your aim is 5, your depth increases by 8*5=40.
    up 3 decreases your aim by 3, resulting in a value of 2.
    down 8 adds 8 to your aim, resulting in a value of 10.
    forward 2 adds 2 to your horizontal position, a total of 15. Because your aim is 10, your depth increases by 2*10=20 to a total of 60.
    After following these new instructions, you would have a horizontal position of 15 and a depth of 60. (Multiplying these produces 900.)

    Using this new interpretation of the commands, calculate the horizontal position and depth you would have after following the planned course. What do you get if you multiply your final horizontal position by your final depth?
  """

  @type horizontal_position :: integer()
  @type depth :: integer()
  @type aim :: integer()
  @type coordinates :: {horizontal_position, depth, aim}
  @type planned_course :: integer()

  @spec perform(binary) :: planned_course
  def perform(input) do
    h_pos = depth = aim = 0
    initial_coordinates = {h_pos, depth, aim}

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
  def calculate_movement(_commands = "forward" <> " " <> value, _coordinates = {h_pos, depth, aim}) do
    h_pos = h_pos + String.to_integer(value)
    depth = depth +  aim * String.to_integer(value)
    {h_pos, depth, aim}
  end

  def calculate_movement(_commands = "down" <> " " <> value, _coordinates = {h_pos, depth, aim}) do
    aim = aim + String.to_integer(value)
    {h_pos, depth, aim}
  end

  def calculate_movement(_commands = "up" <> " " <> value, _coordinates = {h_pos, depth, aim}) do
    aim = aim - String.to_integer(value)
    {h_pos, depth, aim}
  end

  def calculate_movement(_commands = "", coordinates), do: coordinates

  @spec multiply_quantities(coordinates) :: planned_course
  def multiply_quantities(_coordinates = {h_pos, depth, _aim}), do: h_pos * depth
end
