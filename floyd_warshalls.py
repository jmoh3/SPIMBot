vertices = [ (3, 3),
(8, 3),
(14, 3),
(21, 3),
(25, 3),
(11, 6),
(18, 6),
(3, 8),
(14, 8),
(25, 8),
(9, 11),
(20, 11),
(3, 14),
(25, 14),
(9, 15),
(20, 15),
(3, 18),
(9, 18),
(19, 18),
(25, 18),
(3, 22),
(12, 22),
(17, 22),
(25, 22),
(3, 26),
(7, 26),
(15, 26),
(20, 26),
(25, 26),
]

edges = [ (0, 1),
(0, 7),
(1, 2),
(2, 5),
(2, 8),
(2, 6),
(2, 3),
(3, 4),
(4, 9),
(5, 8),
(6, 8),
(7, 12),
(8, 10),
(8, 11),
(9, 13),
(10, 12),
(10, 14),
(11, 15),
(11, 13),
(12, 14),
(12, 17),
(12, 16),
(13, 15),
(13, 18),
(13, 19),
(14, 17),
(15, 18),
(16, 17),
(16, 20),
(17, 21),
(18, 19),
(18, 22),
(19, 23),
(20, 24),
(21, 26),
(22, 26),
(23, 28),
(24, 25),
(25, 26),
(26, 27),
(27, 28)
]

# let dist be a |V|×|V| array of minimum distances initialized to ∞
# let next be a |V|×|V| array of vertex indices initialized to null

# procedure FloydWarshallWithPathReconstruction ()
#    for each edge (u,v)
#       dist[u][v] ← w(u,v)  // the weight of the edge (u,v)
#       next[u][v] ← v
#    for each vertex v
#       dist[v][v] ← 0
#       next[v][v] ← v
#    for k from 1 to |V| // standard Floyd-Warshall implementation
#       for i from 1 to |V|
#          for j from 1 to |V|
#             if dist[i][j] > dist[i][k] + dist[k][j] then
#                dist[i][j] ← dist[i][k] + dist[k][j]
#                next[i][j] ← next[i][k]

# procedure Path(u, v)
#    if next[u][v] = null then
#        return []
#    path = [u]
#    while u ≠ v
#        u ← next[u][v]
#        path.append(u)
#    return path

for edge in edges:
    print(f'.half {edge[0]}, {edge[1]}')