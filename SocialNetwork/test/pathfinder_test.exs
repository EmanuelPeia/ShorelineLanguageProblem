defmodule PathfinderTest do
  use ExUnit.Case

  test "directly complete size three" do
    one = "adam"
    two = "eve"
    three = "set"

    graph = Graph.addNode(%{}, one)
    graph = Graph.addNode(graph, two)
    graph = Graph.addNode(graph, three)

    friends = Graph.getEdges(graph, one)

    assert friends == []

    graph = Graph.linkNodes(graph, one, two)
    graph = Graph.linkNodes(graph, one, three)
    graph = Graph.linkNodes(graph, two, three)

    friends = Graph.getEdges(graph, three)

    assert friends == [one, two]

    from = one
    to = three
    length = Pathfinder.lengthBetween(graph, from, to)

    assert 1 == length
  end

  test "from file sparse size ten" do
    graph = Builder.loadFromFile("test/graphs/ten.txt")

    from = 8
    to = 3
    length = Pathfinder.lengthBetween(graph, from, to)

    assert 3 == length
  end

  test "generated binary tree size ten" do
    n = :rand.uniform(15)
    root = "r"
    graph = Builder.generateBinaryTree(root, n)

    from = for i <- 1..n, do: 1 - rem(i, 2)
    from = Enum.join([root] ++ from, ".")

    to = for i <- 1..n, do: rem(i, 2)
    to = Enum.join([root] ++ to, ".")

    length = Pathfinder.lengthBetween(graph, from, to)

    assert 2 * n == length
  end

  test "from file complete size seven" do
    graph = Builder.loadFromFile("test/graphs/complete.txt")

    from = :rand.uniform(7)
    to = :rand.uniform(7)
    length = Pathfinder.lengthBetween(graph, from, to)

    expected =
      case from == to do
        true -> 0
        false -> 1
      end

    assert expected == length
  end

  test "generated chain size random" do
    size = :rand.uniform(100_000)
    graph = Builder.generateChain(size)

    from = :rand.uniform(size)
    to = :rand.uniform(size)
    length = Pathfinder.lengthBetween(graph, from, to)

    expected = abs(to - from)

    assert expected == length
  end
end
