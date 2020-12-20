12 Speed
================

## Vectorized Code

> The fastest R code will usually take advantage of three things:
> 
>   - logical tests,
>   - subsetting, and
>   - element-wise execution

**`for` version**

``` r
abs_loop <- function(vec){
  for (i in 1:length(vec)) {
    if (vec[i] < 0) {
      vec[i] <- -vec[i]
    }
  }
  vec
}
```

**Vectorized version**

``` r
abs_sets <- function(vec){
  negs <- vec < 0
  vec[negs] <- vec[negs] * -1
  vec
}
```

**Benchmark**

``` r
long <- rep(c(-1, 1), 1000000)
```

> `rep` repeats a value, or vector of values, many times. To use \`rep,
> give it a vector of values and then the number of times to repeat the
> vector. R will return the results as a new, longer vector.

``` r
system.time(abs_loop(long))
```

    ##    user  system elapsed 
    ##   0.124   0.005   0.131

``` r
system.time(abs_sets(long))
```

    ##    user  system elapsed 
    ##   0.025   0.009   0.034

> Many preexisting R functions are already vectorized and have been
> optimized to perform quickly.

``` r
system.time(abs(long))
```

    ##    user  system elapsed 
    ##   0.004   0.000   0.003

## How to Write Vectorized Code

> To create vectorized code:
> 
>   - Use vectorized functions to complete the sequential steps in your
>     program.
>   - Use logical subsetting to handle parallel cases. Try to manipulate
>     every element in a case at once.

``` r
vec <- c(1, -2, 3, -4, 5, -6, 7, -8, 9, -10)
vec[vec < 0] * -1
```

    ## [1]  2  4  6  8 10

**Vectorize a Function**

``` r
change_symbols <- function(vec){
  for (i in 1:length(vec)){
    if (vec[i] == "DD") {
      vec[i] <- "joker"
    } else if (vec[i] == "C") {
      vec[i] <- "ace"
    } else if (vec[i] == "7") {
      vec[i] <- "king"
    }else if (vec[i] == "B") {
      vec[i] <- "queen"
    } else if (vec[i] == "BB") {
      vec[i] <- "jack"
    } else if (vec[i] == "BBB") {
      vec[i] <- "ten"
    } else {
      vec[i] <- "nine"
    } 
  }
  vec
}

vec <- c("DD", "C", "7", "B", "BB", "BBB", "0")

many <- rep(vec, 10000)

system.time(change_symbols(many))
```

    ##    user  system elapsed 
    ##   0.103   0.005   0.112

**Solution**

``` r
change_vec <- function (vec) {
  vec[vec == "DD"] <- "joker"
  vec[vec == "C"] <- "ace"
  vec[vec == "7"] <- "king"
  vec[vec == "B"] <- "queen"
  vec[vec == "BB"] <- "jack"
  vec[vec == "BBB"] <- "ten"
  vec[vec == "0"] <- "nine"
  
  vec
}

system.time(change_vec(many))
```

    ##    user  system elapsed 
    ##   0.009   0.001   0.009

**A better way using a lookup table**

``` r
change_vec2 <- function(vec){
  tb <- c(
    "DD" = "joker",
    "C" = "ace",
    "7" = "king",
    "B" = "queen", 
    "BB" = "jack",
    "BBB" = "ten",
    "0" = "nine"
  )
  
  unname(tb[vec])
}

system.time(change_vec2(many))
```

    ##    user  system elapsed 
    ##   0.003   0.001   0.004

> **if and for**
> 
> A good way to spot `for` loops that could be vectorized is to look for
> combinations of `if` and `for`. `if` can only be applied to one value
> at a time, which means it is often used in conjunction with a `for`
> loop. The `for` loop helps apply `if` to an entire vector of values.
> This combination can usually be replaced with logical subsetting,
> which will do the same thing but run much faster.

## How to Write Fast for Loops in R

> The speed of for loops can be dramatically increase by doing two
> things to optimize each loop:
> 
>   - Do as much as you can outside of the for loop.
>   - Make sure that any storage objects that you use with the loop are
>     large enough to contain all of the results of the loop.

``` r
max <- 1000000
```

``` r
system.time({
  output <- rep(NA, max)
  
  for (i in 1:max) {
    output[i] <- i + 1
  }
})
```

    ##    user  system elapsed 
    ##   0.046   0.003   0.051

``` r
system.time({
  output <- NA 
  
  for (i in 1:max) {
    output[i] <- i + 1
  }
})
```

    ##    user  system elapsed 
    ##   0.278   0.048   0.333

## Vectorized Code in Practice

> The payout rate of the slot machine could be estimate with a
> simulation, by calling the `play` function many, many times. The
> average prize over all of the plays would be a good estimate of the
> true payout rate.
> 
> This method of estimation is based on the *law of large numbers* and
> is similar to many statistical simulations.

``` r
max <- 500000

winnings <- vector(length = max)

for (i in 1:max) {
  winnings[i] <- play()
}

mean(winnings)
```

    ## [1] 0.929744

Let’s see how long take this simulation to run:

``` r
system.time(for (i in 1:max) {
  winnings[i] <- play()
})
```

    ##    user  system elapsed 
    ##   7.866   0.077   8.031

> The current `score` function is not vectorized. It takes a single slot
> combination and uses an `if` tree to assign a prize to it. This
> combination of an `if` tree with a `for` loop suggests that you could
> write a piece of vectorized code that takes many slot combinations and
> then uses logical subsetting to operate on them all at once.

-----

*The vectorize version is omitted here, but could be found in the
corresponding section.*
