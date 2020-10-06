5 R Objects
================

## Atomic Vectors

  - one dimension
  - same data type
      - integer
      - double
      - complex
      - character
      - logical
      - raw

**A vector of one integer**

``` r
number <- 1
is.vector(number)
```

    ## [1] TRUE

**A vector formed by values of a die**

``` r
die <- 1:6
```

**A vector of the powers of 10**

``` r
numbers <- c(1, 10, 100, 1000)
numbers
```

    ## [1]    1   10  100 1000

**The length of the above vector**

``` r
length(numbers)
```

    ## [1] 4

**A vector of one element of type character**

``` r
str <- "hello"
str
```

    ## [1] "hello"

### Double

``` r
x <- 1
typeof(x)
```

    ## [1] "double"

``` r
y <- 0.2
typeof(y)
```

    ## [1] "double"

### Integer

> An integer should end with an ‘L’ in order not to be stored as double

``` r
week_days <- 7L
typeof(week_days)
```

    ## [1] "integer"

### Character

``` r
typeof(str)
```

    ## [1] "character"

### Logical

``` r
is_greater <- 100 > 10
typeof(is_greater)
```

    ## [1] "logical"

### Null values

``` r
none <- NULL
typeof(none)
```

    ## [1] "NULL"

## Attributes

**Common Attributes**

  - names
  - dimensions
  - classes

### Names

**Set Names**

``` r
names(die) <- c("one", "two", "three", "four", "five", "six")
```

**Get Names**

``` r
# by calling names
names(die)
```

    ## [1] "one"   "two"   "three" "four"  "five"  "six"

``` r
# by calling attributes
attributes(die)
```

    ## $names
    ## [1] "one"   "two"   "three" "four"  "five"  "six"

``` r
# by looking at the vector
die
```

    ##   one   two three  four  five   six 
    ##     1     2     3     4     5     6

**Remove Names**

``` r
names(die) <- NULL
names(die)
```

    ## NULL

### Dim

> Transform an atomic vector into an n-dimensional array.

``` r
dim(die) <- c(2, 3)
die
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    3    5
    ## [2,]    2    4    6

## Matrices

``` r
m <- matrix(die, nrow = 2)
m
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    3    5
    ## [2,]    2    4    6

As dim, `matrix` fill the matrix column by column by default. Specifying
the argument `byrow = TRUE` is possible to fill the matrix row by row.

``` r
m <- matrix(die, nrow = 2, byrow = TRUE)
m
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    2    3
    ## [2,]    4    5    6

## Arrays

``` r
a <- array(die, dim = c(2, 3))
a
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    3    5
    ## [2,]    2    4    6

## Class

``` r
dim(die) <- c(2, 3)
# type
typeof(die)
```

    ## [1] "integer"

``` r
# class
class(die)
```

    ## [1] "matrix" "array"

If a object does not have a `class` attribute class will return a value
base on the object atomic type.

``` r
class(number)
```

    ## [1] "numeric"

``` r
class(str)
```

    ## [1] "character"

### Factors

R’s way of storing categorical information.

``` r
color <- factor(c("red", "blue", "green"))
typeof(color)
```

    ## [1] "integer"

``` r
attributes(color)
```

    ## $levels
    ## [1] "blue"  "green" "red"  
    ## 
    ## $class
    ## [1] "factor"

What is storing R?

``` r
color
```

    ## [1] red   blue  green
    ## Levels: blue green red

``` r
unclass(color)
```

    ## [1] 3 1 2
    ## attr(,"levels")
    ## [1] "blue"  "green" "red"

*Factor looks like character but behave like integers.*

Treating as character

``` r
as.character(color)
```

    ## [1] "red"   "blue"  "green"

## Coercion

*If a character is present everything will be converted to a character.*

``` r
v <- c(1, 2, 10, "twelve")
v
```

    ## [1] "1"      "2"      "10"     "twelve"

*If a vector only contains logicals and numbers everything will be
converted to a numbers.*

``` r
v <- c(TRUE, FALSE, 1L, 0L)
v
```

    ## [1] 1 0 1 0

### Explicit Conversion

``` r
as.character(1)
```

    ## [1] "1"

``` r
as.numeric("10")
```

    ## [1] 10

``` r
as.logical(0)
```

    ## [1] FALSE

## Lists

  - One-dimensional data set.
  - Group R objects like vector or other lists.

<!-- end list -->

``` r
l <- list(10, "10", c(1:10), FALSE, list("a", "b", "c"))
l
```

    ## [[1]]
    ## [1] 10
    ## 
    ## [[2]]
    ## [1] "10"
    ## 
    ## [[3]]
    ##  [1]  1  2  3  4  5  6  7  8  9 10
    ## 
    ## [[4]]
    ## [1] FALSE
    ## 
    ## [[5]]
    ## [[5]][[1]]
    ## [1] "a"
    ## 
    ## [[5]][[2]]
    ## [1] "b"
    ## 
    ## [[5]][[3]]
    ## [1] "c"

``` r
# two-system notation
l[[5]][2]
```

    ## [[1]]
    ## [1] "b"

## Data Frames

> Data frames are the two-dimensional version of a list.

``` r
df <- data.frame(
  names = c("one", "two", "three", "four", "five", "six"),  
  values = c(1:6)
)

df
```

    ##   names values
    ## 1   one      1
    ## 2   two      2
    ## 3 three      3
    ## 4  four      4
    ## 5  five      5
    ## 6   six      6

**Data Frame type**

``` r
typeof(df)
```

    ## [1] "list"

**Data Frame class**

``` r
class(df)
```

    ## [1] "data.frame"

**Structure display**

``` r
str(df)
```

    ## 'data.frame':    6 obs. of  2 variables:
    ##  $ names : chr  "one" "two" "three" "four" ...
    ##  $ values: int  1 2 3 4 5 6

> Data frames store one of the most common forms of data used in data
> science, tabular data.

## Loading Data

``` r
deck <- read.csv("deck.csv")
head(deck)
```

    ##    face   suit value
    ## 1  king spades    13
    ## 2 queen spades    12
    ## 3  jack spades    11
    ## 4   ten spades    10
    ## 5  nine spades     9
    ## 6 eight spades     8
