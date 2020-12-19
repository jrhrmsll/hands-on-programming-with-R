9 Programs
================

Randomly generate three symbols:

``` r
get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  
  sample(wheel, size = 3, replace = TRUE, 
    prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}
```

``` r
get_symbols()
```

    ## [1] "DD" "BB" "B"

The full slot machine:

``` r
play <- function() {
  # step 1: generate symbols
  symbols <- get_symbols()

  # step 2: display the symbols
  print(symbols)

  # step 3: score the symbols
  # score(symbols)
}
```

> The `print` command prints its output to the console window, which
> makes print a useful way to display messages from within the body of a
> function.

## if Statements

``` r
x <- 1

if (x > 0) {
  print("x is positive")
}
```

    ## [1] "x is positive"

## else Statements

``` r
x <- -1

if (x > 0) {
  print("x is positive")
} else {
  print("x is negative")
}
```

    ## [1] "x is negative"

> If your situation has more than two mutually exclusive cases, you can
> string multiple `if` and `else` statements together by adding a new
> `if` statement immediately after `else`. For example:

``` r
a <- 1
b <- 1

if (a > b) {
  print("A wins!")
} else if (a < b) {
  print("B wins!")
} else {
  print("Tie.")
}
```

    ## [1] "Tie."

> If two `if` statements describe mutually exclusive events, it is
> better to join the `if` statements with an else `if` than to list them
> separately. This lets R ignore the second if statement whenever the
> first returns a `TRUE`, which saves work.

## Lookup Tables

> As a general rule, use an if tree if each branch of the tree runs
> different code. Use a lookup table if each branch of the tree only
> assigns a different value.
> 
> To convert an if tree to a lookup table, identify the values to be
> assigned and store them in a vector. Next, identify the selection
> criteria used in the conditions of the if tree. If the conditions use
> character strings, give your vector names and use name-based
> subsetting. If the conditions use integers, use integer-based
> subsetting.

## Code Comments

> Comments can make your code easier to understand by explaining why the
> code does what it does.

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

``` r
play <- function() {
  # step 1: generate symbols
  symbols <- get_symbols()

  # step 2: display the symbols
  print(symbols)

  # step 3: score the symbols
  score(symbols)
}
```

> Now it is easy to play the slot machine:

``` r
play()
```

    ## [1] "0" "0" "0"

    ## [1] 0

``` r
play()
```

    ## [1] "B"  "BB" "B"

    ## [1] 5

``` r
play()
```

    ## [1] "0" "B" "B"

    ## [1] 0
