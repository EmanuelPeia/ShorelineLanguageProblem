defmodule GraphTest do
  use ExUnit.Case

  test "add node test" do
    graph = Graph.addNode(%{}, :dummy)

    assert 1 == map_size(graph)
    assert [] == Graph.getEdges(graph, :dummy)
  end

  test "edge test" do
    graph = Graph.addNode(%{}, :one)
    graph = Graph.addNode(graph, :two)
    graph = Graph.linkNodes(graph, :one, :two)

    assert [:two] == Graph.getEdges(graph, :one)
    assert [:one] == Graph.getEdges(graph, :two)
  end

  test "edge number pair test" do
    graph = Graph.addNode(%{}, 1)
    graph = Graph.addNode(graph, 2)
    graph = Graph.linkNumberNodes(graph, "1 2")

    assert [2] == Graph.getEdges(graph, 1)
    assert [1] == Graph.getEdges(graph, 2)
  end
end
