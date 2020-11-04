7 Modifying Values
================

## Changing Values in Place

``` r
vec <- c(0, 0, 0, 0, 0, 0)
vec
```

    ## [1] 0 0 0 0 0 0

Selecting the first value:

``` r
vec[1]
```

    ## [1] 0

Changing the first value:

``` r
vec[1] <- 1000
vec
```

    ## [1] 1000    0    0    0    0    0

Changing multiples values at once:

``` r
vec[c(1, 3, 5)] <- c(1, 10, 100)
vec
```

    ## [1]   1   0  10   0 100   0

> You can also create values that do not yet exist in your object. R
> will expand the object to accommodate the new values:

``` r
vec[7] <- 0
vec
```

    ## [1]   1   0  10   0 100   0   0

Adding a new column to the data frame:

``` r
deck2$new <- 1:52
head(deck2)
```

    ##    face   suit value new
    ## 1  king spades    13   1
    ## 2 queen spades    12   2
    ## 3  jack spades    11   3
    ## 4   ten spades    10   4
    ## 5  nine spades     9   5
    ## 6 eight spades     8   6

Remove the column from the data frame:

``` r
deck2$new <- NULL
head(deck2)
```

    ##    face   suit value
    ## 1  king spades    13
    ## 2 queen spades    12
    ## 3  jack spades    11
    ## 4   ten spades    10
    ## 5  nine spades     9
    ## 6 eight spades     8

## Logical Subsetting

> Logical subsetting provides a way to do targeted extraction and
> modification with R objects, a sort of search-and-destroy mission
> inside your own data sets.

**How many Aces?**

``` r
deck2$face
```

    ##  [1] "king"  "queen" "jack"  "ten"   "nine"  "eight" "seven" "six"   "five" 
    ## [10] "four"  "three" "two"   "ace"   "king"  "queen" "jack"  "ten"   "nine" 
    ## [19] "eight" "seven" "six"   "five"  "four"  "three" "two"   "ace"   "king" 
    ## [28] "queen" "jack"  "ten"   "nine"  "eight" "seven" "six"   "five"  "four" 
    ## [37] "three" "two"   "ace"   "king"  "queen" "jack"  "ten"   "nine"  "eight"
    ## [46] "seven" "six"   "five"  "four"  "three" "two"   "ace"

### Logical Tests

``` r
deck2$face == "ace"
```

    ##  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [13]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [25] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [37] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## [49] FALSE FALSE FALSE  TRUE

``` r
sum(deck2$face == "ace")
```

    ## [1] 4

> You can use this method to spot and then change the aces in your
> deck—even if you’ve shuffled your cards.

``` r
deck3 <- shuffle(deck)
deck3$value[deck3$face == "ace"] # logical indexing
```

    ## [1] 1 1 1 1

Change the `ace` values in `deck3`:

``` r
deck3$value[deck3$face == "ace"] <- 14 # applying recycling rules
deck3$value[deck3$face == "ace"]
```

    ## [1] 14 14 14 14

> Logical subsetting is a powerful technique because it lets you quickly
> identify, extract, and modify individual values in your data set. When
> you work with logical subsetting, you do not need to know where in
> your data set a value exists. You only need to know how to describe
> the value with a logical test.

**Score the Deck for Hearts**

> Assign a value of 1 to every card in deck4 that has a suit of hearts.

``` r
deck4$value[deck4$suit == "hearts"]
```

    ##  [1] 0 0 0 0 0 0 0 0 0 0 0 0 0

``` r
deck4$value[deck4$suit == "hearts"] <- 1
deck4$value[deck4$suit == "hearts"]
```

    ##  [1] 1 1 1 1 1 1 1 1 1 1 1 1 1

> In hearts, the queen of spades has the most unusual value of all:
> she’s worth 13 points.

### Boolean Operators

> Boolean operators combine multiple logical tests together into a
> single test.

  - `&`
  - `|`
  - `xor`
  - `!`
  - `any`
  - `all`

<!-- end list -->

``` r
queenOfSpades <- deck4$face == "queen" & deck4$suit == "spades"
deck4$value[queenOfSpades] <- 13
```

``` r
queens <- deck4$face == "queen"
deck4[queens, ]
```

    ##     face     suit value
    ## 2  queen   spades    13
    ## 15 queen    clubs     0
    ## 28 queen diamonds     0
    ## 41 queen   hearts     1

**Blackjack**

``` r
head(deck5, 13)
```

    ##     face   suit value
    ## 1   king spades    13
    ## 2  queen spades    12
    ## 3   jack spades    11
    ## 4    ten spades    10
    ## 5   nine spades     9
    ## 6  eight spades     8
    ## 7  seven spades     7
    ## 8    six spades     6
    ## 9   five spades     5
    ## 10  four spades     4
    ## 11 three spades     3
    ## 12   two spades     2
    ## 13   ace spades     1

> In blackjack, each number card has a value equal to its face value.
> Each face card (king, queen, or jack) has a value of 10.

``` r
facecard <- deck5$face %in% c("king", "queen", "jack")
deck5$value[facecard] <- 10

head(deck5, 13)
```

    ##     face   suit value
    ## 1   king spades    10
    ## 2  queen spades    10
    ## 3   jack spades    10
    ## 4    ten spades    10
    ## 5   nine spades     9
    ## 6  eight spades     8
    ## 7  seven spades     7
    ## 8    six spades     6
    ## 9   five spades     5
    ## 10  four spades     4
    ## 11 three spades     3
    ## 12   two spades     2
    ## 13   ace spades     1

> Now you just need to fix the ace values—or do you? It is hard to
> decide what value to give the aces because their exact value will
> change from hand to hand. At the end of each hand, an ace will equal
> 11 if the sum of the player’s cards does not exceed 21. Otherwise, the
> ace will equal 1. The actual value of the ace will depend on the other
> cards in the player’s hand. This is a case of missing information.

## Missing Information

> The NA character is a special symbol in R. It stands for “not
> available” and can be used as a placeholder for missing information. R
> will treat NA exactly as you should want missing information treated.

### na.rm

``` r
c(NA, 1:50)
```

    ##  [1] NA  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
    ## [26] 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49
    ## [51] 50

``` r
mean(c(NA, 1:50))
```

    ## [1] NA

> Most R functions come with the optional argument, na.rm, which stands
> for NA remove. R will ignore NAs when it evaluates a function if you
> add the argument na.rm = TRUE:

``` r
mean(c(NA, 1:50), na.rm = TRUE)
```

    ## [1] 25.5

### is.na

The wrong way to test NA:

``` r
NA == NA
```

    ## [1] NA

``` r
c(1, 2, 3, NA) == NA
```

    ## [1] NA NA NA NA

> R supplies a special function that can test whether a value is an NA.
> The function is sensibly named is.na:

``` r
is.na(NA)
```

    ## [1] TRUE

``` r
is.na(c(1, 2, 3, NA))
```

    ## [1] FALSE FALSE FALSE  TRUE

Now is possible to assign NA to ace values in Blackjack:

``` r
deck5$value[deck5$face == "ace"] <- NA
head(deck5, 13)
```

    ##     face   suit value
    ## 1   king spades    10
    ## 2  queen spades    10
    ## 3   jack spades    10
    ## 4    ten spades    10
    ## 5   nine spades     9
    ## 6  eight spades     8
    ## 7  seven spades     7
    ## 8    six spades     6
    ## 9   five spades     5
    ## 10  four spades     4
    ## 11 three spades     3
    ## 12   two spades     2
    ## 13   ace spades    NA
