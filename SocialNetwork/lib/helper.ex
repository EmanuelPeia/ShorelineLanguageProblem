defmodule Helper do
  @moduledoc """
  Utility functions.
  """

  @doc """
  Iterate through `list` and apply `fun` on `target` for each element.
  """
  def applyFunctionArityTwoFromList(target, list, fun) do
    cond do
      list == [] ->
        target

      true ->
        [head | list] = list
        target = fun.(target, head)
        applyFunctionArityTwoFromList(target, list, fun)
    end
  end

  @doc """
  Iterate through `list` and apply `fun` on `target` with one argument `arg` for each element.
  TODO: Since these 2 methods look similar, could we "merge" them somehow to remove duplicate code?
  """
  def applyFunctionArityThreeFromList(target, list, fun, arg) do
    cond do
      list == [] ->
        target

      true ->
        [head | list] = list
        target = fun.(target, head, arg)
        applyFunctionArityThreeFromList(target, list, fun, arg)
    end
  end
end
