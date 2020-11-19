6 R Notation
================

## Selecting Values

> You can select values within an R object with R’s notation system.

    object[<subset of rows>, <subset of columns>]

**Ways of write and index in R**

  - Positive integers
  - Negative integers
  - Zero
  - Blank spaces
  - Logical values
  - Names

### Positive Integers

``` r
head(deck)
```

    ##    face   suit value
    ## 1  king spades    13
    ## 2 queen spades    12
    ## 3  jack spades    11
    ## 4   ten spades    10
    ## 5  nine spades     9
    ## 6 eight spades     8

``` r
# a single value
deck[1, 1]
```

    ## [1] "king"

``` r
# the first row
deck[1, c(1:3)]
```

    ##   face   suit value
    ## 1 king spades    13

``` r
# the first column
deck[1:52, 1]
```

    ##  [1] "king"  "queen" "jack"  "ten"   "nine"  "eight" "seven" "six"   "five" 
    ## [10] "four"  "three" "two"   "ace"   "king"  "queen" "jack"  "ten"   "nine" 
    ## [19] "eight" "seven" "six"   "five"  "four"  "three" "two"   "ace"   "king" 
    ## [28] "queen" "jack"  "ten"   "nine"  "eight" "seven" "six"   "five"  "four" 
    ## [37] "three" "two"   "ace"   "king"  "queen" "jack"  "ten"   "nine"  "eight"
    ## [46] "seven" "six"   "five"  "four"  "three" "two"   "ace"

``` r
# the first row twice (repeating the index)
deck[c(1,1), 1:3]
```

    ##     face   suit value
    ## 1   king spades    13
    ## 1.1 king spades    13

> R’s notation system is not limited to data frames. You can use the
> same syntax to select values in any R object, as long as you supply
> one index for each dimension of the object.

#### Drop

Selecting more than two columns return a **data frame**:

``` r
new_deck <- deck[1, 1:2]
new_deck
```

    ##   face   suit
    ## 1 king spades

``` r
class(new_deck)
```

    ## [1] "data.frame"

Selecting a single column return a **vector**:

``` r
first_column <- deck[1:6, 3]
first_column
```

    ## [1] 13 12 11 10  9  8

``` r
class(first_column)
```

    ## [1] "integer"

By setting `drop = FALSE` is possible to select one column but return a
**data frame**:

``` r
first_column <- deck[1:6, 3, drop = FALSE]
first_column
```

    ##   value
    ## 1    13
    ## 2    12
    ## 3    11
    ## 4    10
    ## 5     9
    ## 6     8

``` r
class(first_column)
```

    ## [1] "data.frame"

### Negative Integers

Negative indexes allow for exclusion:

``` r
# the last row
deck[-(1:51), c(1:3)]
```

    ##    face   suit value
    ## 52  ace hearts     1

> R will return an error if you try to pair a negative integer with a
> positive integer in the same index:

``` r
# deck[-(1:51), c(-1, -2, 3)]
# Error in x[j] : only 0's may be mixed with negative subscripts

# the last column of the last row
deck[-(1:51), c(-1, -2)]
```

    ## [1] 1

### Zero

> R will return nothing from a dimension when you use zero as an index.

``` r
deck[0,0]
```

    ## data frame with 0 columns and 0 rows

### Blank Spaces

> You can use a blank space to tell R to extract every value in a
> dimension.

``` r
# the first row
deck[1, ]
```

    ##   face   suit value
    ## 1 king spades    13

``` r
# the first column
deck[, 1]
```

    ##  [1] "king"  "queen" "jack"  "ten"   "nine"  "eight" "seven" "six"   "five" 
    ## [10] "four"  "three" "two"   "ace"   "king"  "queen" "jack"  "ten"   "nine" 
    ## [19] "eight" "seven" "six"   "five"  "four"  "three" "two"   "ace"   "king" 
    ## [28] "queen" "jack"  "ten"   "nine"  "eight" "seven" "six"   "five"  "four" 
    ## [37] "three" "two"   "ace"   "king"  "queen" "jack"  "ten"   "nine"  "eight"
    ## [46] "seven" "six"   "five"  "four"  "three" "two"   "ace"

``` r
# the first six rows
deck[1:6, ]
```

    ##    face   suit value
    ## 1  king spades    13
    ## 2 queen spades    12
    ## 3  jack spades    11
    ## 4   ten spades    10
    ## 5  nine spades     9
    ## 6 eight spades     8

### Logical Values

``` r
# first two columns of the second row
deck[2, c(TRUE, TRUE, FALSE)]
```

    ##    face   suit
    ## 2 queen spades

### Names

``` r
# the first row
deck[1, c(names(deck))]
```

    ##   face   suit value
    ## 1 king spades    13

``` r
# first two columns of the second row
deck[2, c("face", "suit")]
```

    ##    face   suit
    ## 2 queen spades

## Deal and Shuffle the Deck

``` r
deal <- function(cards) {
  cards[1, ]
}

shuffle <- function(deck) {
  ramdom <- sample(1:52, size = 52)
  deck[ramdom, ]
}
```

``` r
deal(deck)
```

    ##   face   suit value
    ## 1 king spades    13

``` r
deal(deck)
```

    ##   face   suit value
    ## 1 king spades    13

``` r
deck2 <- shuffle(deck)
```

``` r
deal(deck2)
```

    ##     face   suit value
    ## 50 three hearts     3

## Dollar Signs and Double Brackets

> Two types of object in R obey an optional second system of notation.
> You can extract values from data frames and lists with the $ syntax.

``` r
values <- deck$value
typeof(values)
```

    ## [1] "integer"

### $ notation and list

> If you subset a list in the usual way, R will return a new list that
> has the elements you requested.

``` r
l <- list(numbers = 1:10, letters = c("a", "b", "c"))
```

**If the list is subset with the usual notation the result will be a new
list:**

``` r
l[1]
```

    ## $numbers
    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
typeof(l[1])
```

    ## [1] "list"

``` r
# sum(l[1])
#  Error in sum(l[1]) : invalid 'type' (list) of argument
```

**With the $ notation the values will be selected as they are:**

``` r
l$numbers
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
typeof(l$numbers)
```

    ## [1] "integer"

``` r
sum(l$numbers)
```

    ## [1] 55

**Using double brackets will do the same as $ notation**

``` r
l[[1]]
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
typeof(l[[1]])
```

    ## [1] "integer"

Double brackets can be combined with the other indexing approaches:

``` r
l[["numbers"]]
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10
