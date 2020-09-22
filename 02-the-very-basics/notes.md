2 The Very Basics
================

## Some expressions

``` r
2+2
```

    ## [1] 4

``` r
# sequences
1:10
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

## Objects

``` r
# assignments
die <- 1:6
die
```

    ## [1] 1 2 3 4 5 6

### Vector Recycling

``` r
die + 1:2
```

    ## [1] 2 4 4 6 6 8

``` r
die + 1:4
```

    ## Warning in die + 1:4: longer object length is not a multiple of shorter object
    ## length

    ## [1] 2 4 6 8 6 8

## Functions

``` r
round(2/3, 4)
```

    ## [1] 0.6667

``` r
mean(1:10)
```

    ## [1] 5.5

``` r
factorial(7)
```

    ## [1] 5040

### Arguments

``` r
args(sample)
```

    ## function (x, size, replace = FALSE, prob = NULL) 
    ## NULL

``` r
sample(x = die, size = 1)
```

    ## [1] 5
