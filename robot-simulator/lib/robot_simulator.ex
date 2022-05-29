defmodule Robot do
  defstruct position: {0, 0}, direction: :north
end

defmodule RobotSimulator do
  @type robot() :: any()
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  alias Robot

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """

  @spec create() :: robot()
  def create(), do: %Robot{}

  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction, position) do
    cond do
      valid_direction?(direction) and valid_position?(position) ->
        %Robot{direction: direction, position: position}

      valid_position?(position) ->
        {:error, "invalid direction"}

      valid_direction?(direction) ->
        {:error, "invalid position"}

      true ->
        {:error, "invalid direction or position"}
    end
  end

  defp valid_direction?(direction) do
    if direction in [:north, :east, :south, :west], do: true, else: false
  end

  defp valid_position?({x, y}) do
    if is_integer(x) and is_integer(y), do: true, else: false
  end

  defp valid_position?(_), do: false

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, instructions) when instructions == "", do: robot

  def simulate(robot, instructions) do
    [head | _tail] = instructions |> String.split("") |> Enum.reject(&(&1 == ""))
    updated_robot = robot |> change(head)

    case updated_robot do
      {:error, "invalid instruction"} -> {:error, "invalid instruction"}
      _ -> simulate(updated_robot, instructions |> String.slice(1..-1))
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot) do
    Map.get(robot, :direction)
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot) do
    Map.get(robot, :position)
  end

  defp change(robot, rotate_to) when rotate_to == "L" or rotate_to == "R" do
    case robot.direction do
      :north ->
        if rotate_to == "L", do: %{robot | direction: :west}, else: %{robot | direction: :east}

      :east ->
        if rotate_to == "L", do: %{robot | direction: :north}, else: %{robot | direction: :south}

      :south ->
        if rotate_to == "L", do: %{robot | direction: :east}, else: %{robot | direction: :west}

      :west ->
        if rotate_to == "L", do: %{robot | direction: :south}, else: %{robot | direction: :north}

      _ ->
        robot
    end
  end

  defp change(robot, advance_to) when advance_to == "A" do
    case robot.direction do
      :north -> %{robot | position: {elem(robot.position, 0), elem(robot.position, 1) + 1}}
      :east -> %{robot | position: {elem(robot.position, 0) + 1, elem(robot.position, 1)}}
      :south -> %{robot | position: {elem(robot.position, 0), elem(robot.position, 1) - 1}}
      :west -> %{robot | position: {elem(robot.position, 0) - 1, elem(robot.position, 1)}}
      _ -> robot
    end
  end

  defp change(_robot, _), do: {:error, "invalid instruction"}
end
