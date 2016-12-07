#Hmw4

##1. 
(20 pts) Find everything about the country whose name is Afghanistan
in language English (“everything” means all properties of the country).

```
SELECT ?property, ?value WHERE
{
?country rdf:type dbo:Country ; rdfs:label "Afghanistan"@en; ?property ?value
}
```

Query returned all the properties of the country Afghanistan.


##2. 
(15 pts) Who is Barak Obama?

```
SELECT ?abstract
WHERE
{
?person rdf:type dbo:Person ;
rdfs:label "Barack Obama"@en ;
dbo:abstract ?abstract FILTER(LANG(?abstract)="en")
}
```

We can gather from the query results that Barak Obama is the 44th President of the United States.

##3. 
(15 pts) Where is Greece?

```
SELECT ?location WHERE {
?country rdf:type dbo:Country; rdfs:label "Greece"@en; georss:point ?location
}
```

The GPS coords. of Greece are: 37.96666666666667 23.716666666666665

##4. 
(15 pts) What is the capital of Nepal?

```
SELECT ?name
WHERE {
?country rdf:type dbo:Country. ?country rdfs:label "Nepal"@en. ?country dbo:capital ?capital. ?capital rdf:type dbo:City. ?capital rdfs:label ?name.
FILTER (lang(?name) = 'en')
}
```

The capital of Nepal is Kathmandu.

##5. 
(15 pts) What is the area of work of Albert Einstein?

```
SELECT ?out
WHERE {
?person rdf:type dbo:Person.
?person rdfs:label "Albert Einstein"@en. ?person dbo:field ?field.
?field rdfs:label ?out
FILTER (lang(?out) = 'en')
}
```

Albert Einstein worked in Philosophy and Physics.


##6. 
(20 pts) How is India related to “Indira Gandhi”? (no need to find all existing relationships, but find at least an interesting one)

```
SELECT ?subject, ?object, ?info WHERE {
?subject rdf:type dbo:Person ; rdfs:label "Indira Gandhi"@en ; ?object ?info
FILTER regex(?info, "India") }
```


From the query it looks like Indira Gandi was the 3rd Prime Minister of India.