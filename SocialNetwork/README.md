# SocialNetwork

This project is a solution to the following problem:
"We are building a social network.  In this social network, each user has friends.

A chain of friends between two users, user A and user B, is a sequence of users starting with A and ending with B, such that for each user in the chain, ua, the subsequent user, ua + 1, are friends.

Given a social network and two users, user A and user B, please write a function that computes the length of the shortest chain of friends between A and B."

Comments about implementation:
1. How did you represent the social network?  Why did you choose this representation?
 - The social network is represented as a map where the keys are user ids (no specific data type enforced) and the values are arrays of user ids. At an abstract level this map is used as a Graph (see module Graph).
 - I chose a representation as simple as possible, because my objective was to have the shortest path function as performant as possible, independent of how the architecture of such a social network might be developed further. 
2. What algorithm did you use to compute the shortest chain of friends?  What alternatives did you consider?  Why did you choose this algorithm over the alternatives?
 - I used the BFS algorithm and I don't know any viable alternative as a base level. I think there are lots of heuristic optimizations that can be added on top of the base algorithm for specific network topologies.
 - I considered as alternative starting the same algorithm but from multiple nodes in parallel and wait for the first one to finish. The simplest possible improvement would be to start the BFS from both nodes in the pair and stop when either of them finishes as the result is mathematically guaranteed to be the same.
 - I took into consideration a parallel algorithm. Due to time constraints and the fact that I've just started learning Elixir this week, I didn't attempt such an algorithm (I know about parallel implementations of BFS / Dijkstra algorithms, but they are quite complex and include tradeoffs). As an anticipation of a simple improvement on the current solution, I think the unvisited and predecesors update could be parallelized (Pathfinder.ex lines 36-46).
3. Please enumerate the test cases you considered and explain their relevance.
 - I've used a Builder module to construct my test case graphs.
 - I've used a Graph module to construct an unweighted undirected graph which uses the Map module.
 - I've used a Helper module for list processing over maps.
 - The BFS algorithm is in the Pathfinder module.
 - Test cases:
  - "directly complete size three" - first test added just tests against very simple graph
  - "from file sparse size ten" - a custom small graph
  - "generated binary tree size ten" - a graph that can be dynamically generated with various depth and for which is easy to specify a pair of nodes and the expected length between them; such a topology includes worst case scenarios for graph traversal; test runs could vary from one run to another if the from, to and expected length are computed by counting the dots in the ids. I've also used this test case as a small benchmark. For a binary tree of depth 15, it takes about 30 seconds to compute the distance between 2 leaves. This obviously needs to be improved..
  - "from file complete size seven" - custom case where all chains have length 1
  - "generated chain size random" - network with no branches; such a topology includes highest possible chain lengths