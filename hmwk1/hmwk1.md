#HMWK 1

##I


```
class Person (extent persons key ssn) { 
  attribute string name;
  attribute string ssn;
  attribute Date dob; 
}

class Boat (extent boats key name) { 
  attribute string name;
  attribute int tonnage;
  attribute set<string> racesWon; 
  relationship set<Ownership> belongedTo;
}

class Ownership (extent ownerships) { 
  attribute Date begin;
  attribute Date end;
  relationship set<Person> coOwners; 
  relationship Boat boat inverse Boat::belongedTo;
}

```


Propose an SQL schema to model this data relationally. 

```
CREATE TABLE Persons (
    ssn integer NOT NULL,
    name character varying(35),
    dob date,
);

CREATE TABLE Races (
  name character varing(35)
)

CREATE TABLE Wins (
  boat character varying(35) foreign_key(boats.name)
  race character varying(35) forign_key(races.name)
)

CREATE TABLE Boats (
    name character varying(35),
    tonnage int
);

CREATE TABLE Ownerships (
    begin date,
    end date,
    coOwner int, foreign_key(persons.ssn)
    boat int, foreign_key(boats.name)
);

```


##II
Express the following queries in OQL

###1
For the boats who won the “Americas Cup” title, return the (boat, owner) object pairs. The query result should have type set<struct { Boat boat, Person owner }>.
  
```
select struct(boat: b, owner:b.belongedTo)
from b in boats, r in b.racesWon
where "Americas Cup" in r
```  

###2
Find the boat(s) ever owned by “Jack Sparrow”. The query result should have type set<Boat>.

```
select b
from b in boats, owners in b.owners
where "Jack Sparrow" in owners
```

###3
Now assume that the definition of class `Person` is enriched with the declaration

```
class Person (extent persons key ssn) { 
  attribute string name;
  attribute string ssn;
  attribute Date dob; 
  relationship set<Ownership> ownerships inverse Ownership::coOwners; 
}
```

and redo query II.2 exploiting this relationship.
Find the boat(s) ever owned by “Jack Sparrow”. The query result should have type set<Boat>.

```
select o.boat
from p in persons, o in p.ownerships
where p.name == "Jack Sparrow"

```


###4
Find the boat(s) most recently owned by “Jack Sparrow”. The query result should have type set<Boat>.

```
select b
from b in boats, ownership b.belonged_to
where "Jack Sparrow" in ownership.belongedTo
ordered by ownership.end
```

###5

Dropping the assumption of point 3., find the owners (return the objects themselves) of all “Americas Cup”-winning boats.

```
Select b.belongedTo.coOwners
From b in boats
Where "Americas Cup" in b.racesWon and 
for all o in ownerships : o.boat in b
```


##III

Express the queries II.1, II.2, II.4 and II.5 in QBE, on the schema of point I. Instead of returning objects, return the 
key of the corresponding entities.

###1

For the boats who won the “Americas Cup” title, return the (boat, owner) object pairs. The query result should have type set<struct { Boat boat, Person owner }>.

| Win | boat | race         |
|-----|------|--------------|
|     | _b   | Americas Cup |


| Ownership | begin | end |  coOwner   | boat |
|-----------|:-----:|----:|------------|------|
|           |       |     |     _p     |  _b  |

| Person | name | ssn | dbo |
|--------|:----:|----:|-----|
|        | P._n | _p  |     |

###2

Find the boat(s) ever owned by “Jack Sparrow”. 

| Boat | name | tonnage |
|------|------|---------|
|      | P._b |         |

| Ownership | begin | end |  coOwners  | boat |
|-----------|:-----:|----:|------------|------|
|           |       |     |     _s     |  _b  |

| Person       | name | ssn | dbo |
|--------------|:----:|----:|-----|
| Jack Sparrow |      |  _s |     |


### 3

Find the boat(s) most recently owned by “Jack Sparrow”. 

| Boat | name | tonnage |
|------|------|---------|
|      | P._b |         |

| Ownership | begin | end |  coOwners  | boat |
|-----------|:-----:|----:|------------|------|
|           |       |  AO |     _s     |  _b  |

| Person       | name | ssn | dbo |
|--------------|:----:|----:|-----|
| Jack Sparrow |      |  _s |     |


### 4

Find the owners (return the objects themselves) of _all_ “Americas Cup”-winning boats.

Stage I: Boats that haven't won any Americas Cups

| Win | boat | race         |
|-----|------|--------------|
|     |  _b  | Americas Cup |

| Ownership | begin | end |  coOwners  | boat |
|-----------|:-----:|----:|------------|------|
|           |       |     |     _s     |  _b  |

| bad-person | person |
|------------|--------|
|      I     |   _s   |

Stage II: Complement the set of winners from the previous phase

| bad-person | person |
|------------|--------|
|      ¬     |   _s   |

| Person       | name | ssn | dbo |
|--------------|:----:|----:|-----|
|              |  P   | _s  |



