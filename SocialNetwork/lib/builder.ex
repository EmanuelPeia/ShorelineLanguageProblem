defmodule Builder do
  @moduledoc """
  Generates unweighted, undirected graphs through various means
  """

  @doc """
  Generates a binary tree with `depth` levels. `root` is the id of the root node.
  """
  def generateBinaryTree(root, depth) do
    graph = Graph.addNode(%{}, root)
    generateBinaryTreeRec(graph, root, depth)
  end

  defp generateBinaryTreeRec(graph, node, depth) do
    cond do
      depth == 0 ->
        graph

      true ->
        # Append 0 for left and 1 for right for easy path tracking
        left = "#{node}.#{0}"
        right = "#{node}.#{1}"

        # Add left and right to graph
        graph = Helper.applyFunctionArityThreeFromList(graph, [left, right], &Map.put/3, [])

        graph = Graph.linkNodes(graph, node, left)
        graph = Graph.linkNodes(graph, node, right)

        # Generate left-side sub-tree
        graph = generateBinaryTreeRec(graph, left, depth - 1)

        # Generate right-side sub-tree
        generateBinaryTreeRec(graph, right, depth - 1)
    end
  end

  @doc """
  Generates a chain with link from 1 to `max`i
  """
  def generateChain(max) do
    graph = Graph.addNode(%{}, 1)
    generateChainRec(graph, max, 1)
  end

  defp generateChainRec(graph, max, current) do
    cond do
      current == max ->
        graph

      true ->
        graph = Graph.addNode(graph, current + 1)
        graph = Graph.linkNodes(graph, current, current + 1)
        generateChainRec(graph, max, current + 1)
    end
  end

  @doc """
  Create graph from a file. First line contains number of nodes. 
  The rest of the lines contain a space separated pair of nodes.
  """
  def loadFromFile(path) do
    {:ok, file} = File.read(path)
    lines = file |> String.split("\r\n", trim: true)
    count = String.to_integer(hd(lines))

    # Add nodes
    graph = Helper.applyFunctionArityThreeFromList(%{}, Enum.to_list(1..count), &Map.put/3, [])
    pairs = tl(lines)

    # Add edges
    graph = Helper.applyFunctionArityTwoFromList(graph, pairs, &Graph.linkNumberNodes/2)
    graph
  end
end
