


## GSON nested property

https://code.amazon.com/reviews/CR-3754768/revisions/1#/details

## GSON tutorial
http://tutorials.jenkov.com/java-json/gson.html


## Java 8 lambda

https://www.youtube.com/watch?v=YnzisJh-ZNI&t=1532s

conclusion:

1. lambdas (anonymous functions) should be one liner, should not exists: "-> {...}"
 
> extract heavy lambdas into names ::methods
\
1. inthe same same class
2. in the item class
3. as static methods


2. [correct] no nullable parameters

also, no optional parameters..

avoid returning null, throw exceptions..

return an optional instead (如果可以的话)

如果有多个optional包裹的话，使用 .flatmap将其拆开

3. [Incorrect] Avoid execute arbiturary logic within a function

* cpp
* +1 boolean param
* extract & override
* tempate method

instead: passing-a-block

```java
exporter.exportFile("order.csv", orderWriter::writeContent);

...

try (Writer writer = new FileWriter(file)) {
  contentWriter.accept(writer);
  return file;
} catch(..) {
}

```

contentWriter is "loaned" a Writer managed here


infrastructure decoupled from export format

4. preper runtime exceptions

Java8 functional interfaces don't throw anything

rethrow checked as runtime
  libs: jool, vavr, lombok etc.. ??
  

5. Type-specific logic

>
1. switch
  switch hunt day: hope to find them all: JDD
  Simpliest: 1 switch 1 method,...
\ 
2. enum
  Logic bits: in enum methods
  Logic with dependencies: __function__ references on enums



reference: https://dzone.com/articles/functional-programming-patterns-with-java-8



