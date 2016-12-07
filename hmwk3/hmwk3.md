# HMWK 3

## 1

Find persons who served as both actor and director in the same movie (display person name and movie title).

```
MATCH(p:Person)-[:ACTED_IN]->(m)<-[:DIRECTED]-(p) RETURN p.name, m.title
```

```
╒══════════════╤═════════════════╕
│p.name        │m.title          │
╞══════════════╪═════════════════╡
│Tom Hanks     │That Thing You Do│
├──────────────┼─────────────────┤
│Clint Eastwood│Unforgiven       │
├──────────────┼─────────────────┤
│Danny DeVito  │Hoffa            │
└──────────────┴─────────────────┘
```

## 2

Find the name of directors who have never acted.

```
MATCH(p:Person)-[:DIRECTED]->(m) WHERE NOT (p)-[:ACTED_IN]->() RETURN DISTINCT p.name
```

| p.name               |
| -------------------- |
| Andy Wachowski       |
| Lana Wachowski       |
| Taylor Hackford      |
| Rob Reiner           |
| Tony Scott           |
| Cameron Crowe        |
| James L. Brooks      |
| Vincent Ward         |
| Scott Hicks          |
| Nora Ephron          |
| John Patrick Stanley |
| Howard Deutch        |
| Mike Nichols         |
| Robert Longo         |
| Tom Tykwer           |
| Ron Howard           |
| Frank Darabont       |
| Jan de Bont          |
| Robert Zemeckis      |
| Milos Forman         |
| Nancy Meyers         |
| Chris Columbus       |
| Penny Marshall       |

## 3

For each person who has acted in at least one movie, add a label “Actor” to the node representing this person.

```
MATCH(p:Person)-[:ACTED_IN]->() SET p:Actor
```

## 4

For each actor, add a “roleCount” attribute containing the number of roles the actor has interpreted overall.

```
MATCH(a:Actor)-[act:ACTED_IN]->(m) 
WITH a,sum(size(act.roles)) as num_rls 
SET a.roleCount = num_rls
RETURN a.name, num_rls
ORDER BY num_rls desc
```

| a.name           | num_rls |
| ---------------- | ------- |
| Tom Hanks        | 20      |
| Hugo Weaving     | 10      |
| Meg Ryan         | 7       |
| Keanu Reeves     | 7       |
| Jack Nicholson   | 5       |
| Halle Berry      | 4       |
| Cuba Gooding Jr. | 4       |
| Bill Paxton      | 3       |
| Helen Hunt       | 3       |
| Gene Hackman     | 3       |
| Jim Broadbent    | 3       |
| Carrie-Anne Moss | 3       |

….

## 5

For each director, find the number of roles they have directed (display director name and role number).		

```
match (d)-[:DIRECTED]->(m:Movie)<-[act:ACTED_IN]-(a) 
return  d.name,sum(length(act.roles)) as cnt
ORDER BY cnt desc
```

| d.name          | cnt  |
| --------------- | ---- |
| Andy Wachowski  | 37   |
| Lana Wachowski  | 37   |
| Rob Reiner      | 23   |
| Tom Tykwer      | 17   |
| Ron Howard      | 14   |
| Nora Ephron     | 12   |
| Cameron Crowe   | 9    |
| James Marshall  | 9    |
| Robert Zemeckis | 8    |
| Frank Darabont  | 8    |
| Mike Nichols    | 6    |
| Penny Marshall  | 6    |
| Tony Scott      | 6    |
| Vincent Ward    | 5    |

## 6

Find the name of actors who have worked with every director born after 1966.

```
MATCH(d:Person)-[:DIRECTED]->(), (a:Person) WHERE d.born>1966 
AND NOT ((a)-[:ACTED_IN]->()<-[:DIRECTED]-(d)) 
SET a.badactor=TRUE
MATCH (p:Person) WHERE NOT EXISTS(p.badactor) RETURN DISTINCT (p.name)
```

| p.name)      |
| ------------ |
| Hugo Weaving |
| Ben Miles    |
| Rain         |

## 7

Rename each ACTED_IN relation to APPEARED_IN, preserve the “roles” attribute.

```
match (n1)-[old:ACTED_IN]->(n2)
create (n1)-[new:APPEARED_IN]->(n2)
delete old
```

