defmodule BuilderTest do
  use ExUnit.Case

  test "binary tree generates 2^n - 1 nodes" do
    n = :rand.uniform(12) + 4
    graph = Builder.generateBinaryTree("r", n)

    assert :math.pow(2, n + 1) - 1 == map_size(graph)

    sampleNode = "r.0.1"
    edges = Map.get(graph, sampleNode)

    assert ["r.0", "r.0.1.0", "r.0.1.1"] == edges
  end

  test "chain generates n nodes" do
    n = :rand.uniform(1_000_000)
    graph = Builder.generateChain(n)

    assert n == map_size(graph)

    sampleNode = :rand.uniform(n - 2) + 1
    edges = Map.get(graph, sampleNode)
    assert [sampleNode - 1, sampleNode + 1] == edges

    edges = Map.get(graph, 1)
    assert [2] == edges

    edges = Map.get(graph, n)
    assert [n - 1] == edges
  end

  test "load from file test on ten" do
    graph = Builder.loadFromFile("test/graphs/ten.txt")

    assert 10 == map_size(graph)

    sampleNode = 10
    edges = Map.get(graph, sampleNode)

    assert [2, 7] == edges
  end
end
