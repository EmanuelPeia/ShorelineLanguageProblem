defmodule Pathfinder do
  @moduledoc """
  Finds paths between nodes in a graph.
  """

  @doc """
  Get length of shortest path between `from` and `to` in `graph`
  """
  def lengthBetween(graph, from, to) do
    exploreAndGetMinLength(graph, %{}, %{}, [], nil, from, to)
  end

  @doc """
  Apply BFS on `graph`.
  Steps:
    0. Return lenth if we've reached destination node `to`
    1. Update length based on `from` for `current` node. Set `current` as `visited`.
    2. Update `predecesors` for nodes linked to `current` node.
    3. Add unvisited nodes linked to current node to `queue`.
    4. Recall function with next node in `queue`.
  """
  def exploreAndGetMinLength(graph, visited, predecesors, queue, from, current, to) do
    cond do
      current == to ->
        length = getLength(visited, from)
        length + 1

      true ->
        length = getLength(visited, from)

        # Non-negative length implies node is visited and we're sure on subsequent visits length will not be smaller.
        visited = setLength(visited, current, length + 1)

        edges = Graph.getEdges(graph, current)

        # Don't add to queue nodes that have already been processed or added to the queue
        unvisited =
          Enum.filter(edges, fn edge ->
            cond do
              isVisited(visited, edge) -> false
              Enum.member?(queue, edge) -> false
              true -> true
            end
          end)

        # We need to keep track of predecesors in order to increment length for each node correctly.
        predecesors =
          Helper.applyFunctionArityThreeFromList(predecesors, unvisited, &Map.put/3, current)

        # Nodes in unvisited will surely not have a shortest length than the ones already in queue.
        queue = queue ++ unvisited
        [next | queue] = queue

        # This is required to increment the length correctly as we move away from the initial node.
        previous = Map.get(predecesors, next)

        exploreAndGetMinLength(graph, visited, predecesors, queue, previous, next, to)
    end
  end

  defp setLength(visited, node, length) do
    Map.put(visited, node, length)
  end

  defp getLength(visited, node) do
    length = Map.get(visited, node)

    # -1 means we're at the start `node`.
    case length do
      nil -> -1
      _ -> length
    end
  end

  defp isVisited(visited, node) do
    Map.get(visited, node) != nil
  end
end
