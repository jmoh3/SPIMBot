import math

vertices = [
(3, 3),
(11, 3),
(18, 3),
(25, 3),

(3, 8),
(11, 8),
(18, 8),
(25, 8),

(3, 12),
(8, 12),
(21, 12),
(25, 12),

(3, 17),
(8, 17),
(21, 17),
(25, 17),

(3, 21),
(11, 21),
(18, 21),
(25, 21),

(3, 26),
(11, 26),
(18, 26),
(25, 26)
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

dist = [[math.inf for x in range(len(vertices))] for y in range(len(vertices))]
next = [[-1 for x in range(len(vertices))] for y in range(len(vertices))]

for edge in edges:
    u = vertices[edge[0]]
    v = vertices[edge[1]]

    distance = math.sqrt((u[0] - v[0])**2 + (u[1] - v[1])**2)

    dist[edge[0]][edge[1]] = distance
    next[edge[0]][edge[1]] = edge[1]

    dist[edge[1]][edge[0]] = distance
    next[edge[1]][edge[0]] = edge[0]

for i in range(len(vertices)):
    dist[i][i] = 0
    next[i][i] = i

for k in range(len(vertices)):
    for i in range(len(vertices)):
        for j in range(len(vertices)):
            if dist[i][j] > dist[i][k] + dist[k][j]:
                dist[i][j] = dist[i][k] + dist[k][j]
                next[i][j] = next[i][k]
            if dist[j][i] > dist[j][k] + dist[k][i]:
                dist[j][i] = dist[j][k] + dist[k][i]
                next[j][i] = next[k][i]

# print(next)
new_next = [[[next[u][v], 0, dist[u][v]] for v in range(len(vertices))] for u in range(len(vertices))]

for i in range(len(vertices)):
    for j in range(len(vertices)):
        if i == j:
            continue

        u = vertices[i]
        v = vertices[j]
        b = vertices[next[i][j]]

        # find angle between u and b
        angle = math.atan2(b[1] - u[1], b[0] - u[0])

        # find distance from u to b
        distance = math.sqrt((b[0] - u[0])**2 + (b[1] - u[1])**2)

        new_next[i][j][1] = int(angle)
        new_next[i][j][2] = int(distance)

print('vertices:')
for vertex in vertices:
    print(f'.half: {vertex[0]}, {vertex[1]}')

print('next:')
for row in new_next:
    string = '.half: '
    for elem in row:
        for thing in elem:
            string += str(thing) + ', '
    print(string[:-2])