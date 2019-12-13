defmodule Graph do
  @moduledoc """
  Undirected, unweighted graph stored as a map.
  """

  @doc """
  Put `node` in `graph` with an empty list of edges.
  """
  def addNode(graph, node) do
    Map.put(graph, node, [])
  end

  @doc """
  Get nodes connected to `node` in `graph`.
  """
  def getEdges(graph, node) do
    Map.get(graph, node)
  end

  defp addEdge(graph, nodeFrom, nodeTo) do
    leftEdges = getEdges(graph, nodeFrom)
    Map.put(graph, nodeFrom, leftEdges ++ [nodeTo])
  end

  @doc """
  Connect `nodeFrom` to `nodeTo` and `nodeTo` to `nodeFrom` in `graph`.
  """
  def linkNodes(graph, nodeFrom, nodeTo) do
    graph = addEdge(graph, nodeFrom, nodeTo)
    addEdge(graph, nodeTo, nodeFrom)
  end

  @doc """
  Split `pair` into `nodeFrom` and `nodeTo` and link them.
  """
  def linkNumberNodes(graph, pair) do
    both = String.split(pair)
    nodeFrom = String.to_integer(hd(both))
    nodeTo = String.to_integer(hd(tl(both)))
    linkNodes(graph, nodeFrom, nodeTo)
  end
end
