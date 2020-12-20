11 Loops
================

## expand.grid

> The expand.grid function in R provides a quick way to write out every
> combination of the elements in *n* vectors.

``` r
die <- c(1:6)

rolls <- expand.grid(one = die, two = die)
```

``` r
rolls
```

    ##    one two
    ## 1    1   1
    ## 2    2   1
    ## 3    3   1
    ## 4    4   1
    ## 5    5   1
    ## 6    6   1
    ## 7    1   2
    ## 8    2   2
    ## 9    3   2
    ## 10   4   2
    ## 11   5   2
    ## 12   6   2
    ## 13   1   3
    ## 14   2   3
    ## 15   3   3
    ## 16   4   3
    ## 17   5   3
    ## 18   6   3
    ## 19   1   4
    ## 20   2   4
    ## 21   3   4
    ## 22   4   4
    ## 23   5   4
    ## 24   6   4
    ## 25   1   5
    ## 26   2   5
    ## 27   3   5
    ## 28   4   5
    ## 29   5   5
    ## 30   6   5
    ## 31   1   6
    ## 32   2   6
    ## 33   3   6
    ## 34   4   6
    ## 35   5   6
    ## 36   6   6

Determine the value of each roll:

``` r
rolls$value <- rolls$one + rolls$two

# output of six elements
rolls[sample(c(1:36), 6), ]
```

    ##    one two value
    ## 7    1   2     3
    ## 1    1   1     2
    ## 12   6   2     8
    ## 14   2   3     5
    ## 15   3   3     6
    ## 3    3   1     4

**Probability of each combination (weighted dice)**

> The probability that n independent, random events all occur is equal
> to the product of the probabilities that each random event occurs.

``` r
prob <- c("1" = 1/8, "2" = 1/8, "3" = 1/8, "4" = 1/8, "5" = 1/8, "6" = 3/8)
prob
```

    ##     1     2     3     4     5     6 
    ## 0.125 0.125 0.125 0.125 0.125 0.375

Subset by `rolls$one`:

``` r
prob[rolls$one]
```

    ##     1     2     3     4     5     6     1     2     3     4     5     6     1 
    ## 0.125 0.125 0.125 0.125 0.125 0.375 0.125 0.125 0.125 0.125 0.125 0.375 0.125 
    ##     2     3     4     5     6     1     2     3     4     5     6     1     2 
    ## 0.125 0.125 0.125 0.125 0.375 0.125 0.125 0.125 0.125 0.125 0.375 0.125 0.125 
    ##     3     4     5     6     1     2     3     4     5     6 
    ## 0.125 0.125 0.125 0.375 0.125 0.125 0.125 0.125 0.125 0.375

Adding the probabilities to the data frame:

``` r
rolls$p_one <- prob[rolls$one]
rolls$p_two <- prob[rolls$two]

#  probability of each combination
rolls$prob <- rolls$p_one * rolls$p_two

# output of six elements
rolls[sample(c(1:36), 6), ]
```

    ##    one two value p_one p_two     prob
    ## 27   3   5     8 0.125 0.125 0.015625
    ## 8    2   2     4 0.125 0.125 0.015625
    ## 7    1   2     3 0.125 0.125 0.015625
    ## 35   5   6    11 0.125 0.375 0.046875
    ## 28   4   5     9 0.125 0.125 0.015625
    ## 9    3   2     5 0.125 0.125 0.015625

**Expected value**

``` r
sum(rolls$value * rolls$prob)
```

    ## [1] 8.25

> The expected value of rolling two loaded dice is 8.25.

**Expected value of the slot machine prize**

``` r
wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
```

> Add the argument `stringsAsFactors = FALSE` to your `expand.grid`
> call; otherwise, `expand.grid` will save the combinations as factors,
> an unfortunate choice that will disrupt the score function.

``` r
combinations <- expand.grid(
  first = wheel, 
  second = wheel, 
  third = wheel, 
  stringsAsFactors = FALSE
)

combinations[sample(c(1:nrow(combinations)), 6), ]
```

    ##     first second third
    ## 262   BBB    BBB     C
    ## 197    DD     DD     B
    ## 193    BB      0    BB
    ## 219     7     BB     B
    ## 37      7      C    DD
    ## 296     7     DD     0

> Probabilities of each symbol

``` r
prob <- c(
  "DD" = 0.03,
  "7" = 0.03, 
  "BBB" = 0.06, 
  "BB" = 0.1,
  "B" = 0.25,
  "C" = 0.01,
  "0" = 0.52
)

prob
```

    ##   DD    7  BBB   BB    B    C    0 
    ## 0.03 0.03 0.06 0.10 0.25 0.01 0.52

Let’s calculate the probability of each combination:

``` r
combinations$p_first <- prob[combinations$first]
combinations$p_second <- prob[combinations$second]
combinations$p_third <- prob[combinations$third]

#  probability of each combination
combinations$prob <- combinations$p_first * combinations$p_second * combinations$p_third

# output of six elements
combinations[sample(c(1:nrow(combinations)), 6), ]
```

    ##     first second third p_first p_second p_third     prob
    ## 171   BBB     BB    BB    0.06     0.10    0.10 0.000600
    ## 68      B    BBB     7    0.25     0.06    0.03 0.000450
    ## 65      7    BBB     7    0.03     0.06    0.03 0.000054
    ## 77      0     BB     7    0.52     0.10    0.03 0.001560
    ## 131     B      B   BBB    0.25     0.25    0.06 0.003750
    ## 272     C     BB     C    0.01     0.10    0.01 0.000010

> The sum of the probabilities is one, which suggests that our math is
> correct:

``` r
sum(combinations$prob)
```

    ## [1] 1

The remaining step is calculate the expected value; to do this the prize
of each combinations must be determine first with the `score` function.

``` r
score <- function (symbols) {
  # identify case
  
  # it's possible to test three of the same type with:
  # length(unique(symbols)) == 1
  same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
  
  bars <- symbols %in% c("B", "BB", "BBB")
  
  # get prize
  if (same) {
    payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, 
      "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[symbols[1]])
  } else if (all(bars)) {
    prize <- 5
  } else {
    cherries <- sum(symbols == "C")
    prize <- c(0, 2, 5)[cherries + 1]
  }
  
  # adjust for diamonds
  diamonds <- sum(symbols == "DD")
  prize * 2 ^ diamonds
}
```

## for Loops

> A for loop repeats a chunk of code many times, once for each element
> in a **set** of input.

``` r
for (v in c(1:6)) {
  print(v)
}
```

    ## [1] 1
    ## [1] 2
    ## [1] 3
    ## [1] 4
    ## [1] 5
    ## [1] 6

Adding a column for prize:

``` r
combinations$prize <- NA
```

Let’s calculate the prize of each row:

``` r
for (i in 1:nrow(combinations)) {
  symbols <- c(combinations[i, 1], combinations[i, 2], combinations[i, 3])
  combinations$prize[i] <- score(symbols)
}
```

``` r
sum(combinations$prize * combinations$prob)
```

    ## [1] 0.538014

> This value is lower than expected, because an important feature of the
> slot machine was ignore: a diamond is wild. You can treat a DD as any
> other symbol if it increases your prize, with one exception. You
> cannot make a DD a C unless you already have another C in your
> symbols.

A version of `score` that handles wild diamonds:

``` r
score <- function(symbols) {
  
  diamonds <- sum(symbols == "DD")
  cherries <- sum(symbols == "C")
  
  # identify case
  # since diamonds are wild, only nondiamonds 
  # matter for three of a kind and all bars
  slots <- symbols[symbols != "DD"]
  same <- length(unique(slots)) == 1
  bars <- slots %in% c("B", "BB", "BBB")

  # assign prize
  if (diamonds == 3) {
    prize <- 100
  } else if (same) {
    payouts <- c("7" = 80, "BBB" = 40, "BB" = 25,
      "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[slots[1]])
  } else if (all(bars)) {
    prize <- 5
  } else if (cherries > 0) {
    # diamonds count as cherries
    # so long as there is one real cherry
    prize <- c(0, 2, 5)[cherries + diamonds + 1]
  } else {
    prize <- 0
  }
  
  # double for each diamond
  prize * 2^diamonds
}
```

**Recompute the expected value:**

``` r
for (i in 1:nrow(combinations)) {
  symbols <- c(combinations[i, 1], combinations[i, 2], combinations[i, 3])
  combinations$prize[i] <- score(symbols)
}
```

``` r
sum(combinations$prize * combinations$prob)
```

    ## [1] 0.934356

## while Loops

> A `while` loop reruns a chunk while a certain condition remains
> `TRUE`.

``` r
i <- 1

while (i <= 10) {
  print(i)
  i <- i + 1
}
```

    ## [1] 1
    ## [1] 2
    ## [1] 3
    ## [1] 4
    ## [1] 5
    ## [1] 6
    ## [1] 7
    ## [1] 8
    ## [1] 9
    ## [1] 10

## repeat Loops

> `repeat` loops are even more basic than `while` loops. They will
> repeat a chunk of code until you tell them to stop (by hitting Escape)
> or until they encounter the command `break`, which will stop the loop.

``` r
i <- 1

repeat {
  print(i)
  
  i <- i + 1
  if (i > 10) {
    break
  }
}
```

    ## [1] 1
    ## [1] 2
    ## [1] 3
    ## [1] 4
    ## [1] 5
    ## [1] 6
    ## [1] 7
    ## [1] 8
    ## [1] 9
    ## [1] 10
