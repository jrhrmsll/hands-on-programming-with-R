8 Environments
================

## Environments

> You can see R’s environment system with the `parenvs` function in the
> `pryr` package. `parenvs(all = TRUE)` will return a list of the
> environments that your R session is using.

``` r
parenvs(all = TRUE)
```

    ##    label                            name               
    ## 1  <environment: R_GlobalEnv>       ""                 
    ## 2  <environment: package:pryr>      "package:pryr"     
    ## 3  <environment: package:stats>     "package:stats"    
    ## 4  <environment: package:graphics>  "package:graphics" 
    ## 5  <environment: package:grDevices> "package:grDevices"
    ## 6  <environment: package:utils>     "package:utils"    
    ## 7  <environment: package:datasets>  "package:datasets" 
    ## 8  <environment: package:methods>   "package:methods"  
    ## 9  <environment: 0x7fbade9b7400>    "Autoloads"        
    ## 10 <environment: base>              ""                 
    ## 11 <environment: R_EmptyEnv>        ""

## Working with Environments

**Refer to an environment**

``` r
as.environment("package:stats")
```

    ## <environment: package:stats>
    ## attr(,"name")
    ## [1] "package:stats"
    ## attr(,"path")
    ## [1] "/Library/Frameworks/R.framework/Versions/4.0/Resources/library/stats"

There are some functions for access to `global`, `base` and `empty`
environments:

``` r
globalenv()
```

    ## <environment: R_GlobalEnv>

``` r
baseenv()
```

    ## <environment: base>

``` r
emptyenv()
```

    ## <environment: R_EmptyEnv>

**Parent environment**

``` r
parent.env(globalenv())
```

    ## <environment: package:pryr>
    ## attr(,"name")
    ## [1] "package:pryr"
    ## attr(,"path")
    ## [1] "/Library/Frameworks/R.framework/Versions/4.0/Resources/library/pryr"

> Notice that the empty environment is the only R environment without a
> parent:

``` r
# parent.env(emptyenv())
# Error in parent.env(emptyenv()) : the empty environment has no parent
```

> You can view the objects saved in an environment with `ls` or
> `ls.str`. `ls` will return just the object names, but `ls.str` will
> display a little about each object’s structure:

``` r
ls(emptyenv())
```

    ## character(0)

``` r
ls(globalenv())
```

    ## [1] "deck"

``` r
ls.str(globalenv())
```

    ## deck : 'data.frame': 52 obs. of  3 variables:
    ##  $ face : chr  "king" "queen" "jack" "ten" ...
    ##  $ suit : chr  "spades" "spades" "spades" "spades" ...
    ##  $ value: int  13 12 11 10 9 8 7 6 5 4 ...

> You can use R’s $ syntax to access an object in a specific
> environment. For example, you can access deck from the global
> environment:

``` r
head(globalenv()$deck)
```

    ##    face   suit value
    ## 1  king spades    13
    ## 2 queen spades    12
    ## 3  jack spades    11
    ## 4   ten spades    10
    ## 5  nine spades     9
    ## 6 eight spades     8

**`assing` function**

``` r
assign("number", 100, envir = globalenv()) #  works similar to <-
globalenv()$number
```

    ## [1] 100

### The Active Environment

``` r
environment()
```

    ## <environment: R_GlobalEnv>

## Scoping Rules

> 1.  R looks for objects in the current active environment.
> 2.  When you work at the command line, the active environment is the
>     global environment. Hence, R looks up objects that you call at the
>     command line in the global environment.
> 3.  When R does not find an object in an environment, R looks in the
>     environment’s parent environment, then the parent of the parent,
>     and so on, until R finds the object or reaches the empty
>     environment.

## Evaluation

**Runtime environment**

``` r
show_env <- function(){
  list(
    ran.in = environment(), 
    parent = parent.env(environment()), 
    objects = ls.str(environment())
  )
}

show_env() # R creates a new environment each time you run a function.
```

    ## $ran.in
    ## <environment: 0x7fbadec4e520>
    ## 
    ## $parent
    ## <environment: R_GlobalEnv>
    ## 
    ## $objects

**Origin environment**

> R will connect a function’s runtime environment to the environment
> that the function was first created in. Let’s call this environment
> the *origin environment*. You can look up a function’s origin
> environment by running environment on the function:

``` r
environment(show_env)
```

    ## <environment: R_GlobalEnv>

**Objects inside runtime environment**

> Any objects created by the function are stored in a safe,
> out-of-the-way runtime environment.

``` r
show_env <- function(){
  text <- "sample text"
  
  list(
    ran.in = environment(), 
    parent = parent.env(environment()), 
    objects = ls.str(environment())
  )
}

show_env()
```

    ## $ran.in
    ## <environment: 0x7fbae11bd228>
    ## 
    ## $parent
    ## <environment: R_GlobalEnv>
    ## 
    ## $objects
    ## text :  chr "sample text"

> If a function has arguments, R will copy over each argument to the
> *runtime environment*.

``` r
show_env <- function(text){
  list(
    ran.in = environment(), 
    parent = parent.env(environment()), 
    objects = ls.str(environment())
  )
}

show_env("sample text")
```

    ## $ran.in
    ## <environment: 0x7fbadf244820>
    ## 
    ## $parent
    ## <environment: R_GlobalEnv>
    ## 
    ## $objects
    ## text :  chr "sample text"

**Fixing `deal` and `shuffle` functions**

> The following code will save a prisitine copy of deck and then remove
> the top card:

``` r
DECK <- deck

deck <- deck[-1, ]
```

``` r
deal <- function() {
  deck[1, ]
}

environment(deal)
```

    ## <environment: R_GlobalEnv>

> `deal` returns the top card of deck but does not remove the card from
> the deck. As a result, deal always returns the same card:

``` r
deal()
```

    ##    face   suit value
    ## 2 queen spades    12

``` r
deal()
```

    ##    face   suit value
    ## 2 queen spades    12

``` r
deal <- function() {
  card <- deck[1, ]
  
  # deck <- deck[-1, ] only create a copy of deck in the function
  # runtime environment
  
  assign("deck", value = deck[-1, ], envir = globalenv())
  card
}

deal()
```

    ##    face   suit value
    ## 2 queen spades    12

``` r
deal()
```

    ##   face   suit value
    ## 3 jack spades    11

``` r
deal()
```

    ##   face   suit value
    ## 4  ten spades    10

> `shuffle` doesn’t shuffle the deck object; it returns a shuffled copy
> of the deck object:

``` r
shuffle <- function(cards) { 
  random <- sample(1:52, size = 52)
  cards[random, ]
}
```

``` r
head(deck, 3)
```

    ##    face   suit value
    ## 5  nine spades     9
    ## 6 eight spades     8
    ## 7 seven spades     7

``` r
head(shuffle(deck), 3)
```

    ##     face   suit value
    ## 17   ten  clubs    10
    ## 45 eight hearts     8
    ## 10  four spades     4

``` r
head(deck, 3)
```

    ##    face   suit value
    ## 5  nine spades     9
    ## 6 eight spades     8
    ## 7 seven spades     7

Fixing it\!

``` r
shuffle <- function(){
  random <- sample(1:52, size = 52)
  assign("deck", DECK[random, ], envir = globalenv())
}
```

``` r
shuffle()
```

``` r
deal()
```

    ##    face   suit value
    ## 40 king hearts    13

``` r
deal()
```

    ##    face  suit value
    ## 22 five clubs     5

## Closures

*What happen if `deck` or/and `DECK` are modified or erase from the
global environment?*

``` r
# rm(deck)

# shuffle()
# object 'deck' not foundError in shuffle() : could not find function "shuffle"
```

> It would be better if we could store deck in a safe, out-of-the-way
> place, like one of those safe, out-of-the-way environments that R
> creates to run functions in. In fact, storing deck in a runtime
> environment is not such a bad idea.

``` r
setup <- function(deck) {
  DECK <- deck

  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = globalenv())
    card
  }

  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = globalenv())
 }

  # return functions as a list
  list(deal = DEAL, shuffle = SHUFFLE)
}
```

> Save each of the elements of the list to a dedicated object in the
> global environment:

``` r
cards <- setup(deck)

deal <- cards$deal
shuffle <- cards$shuffle
```

Now, global environment is not longer their *original environment*:

``` r
environment(deal)
```

    ## <environment: 0x7fbae17bd928>

``` r
environment(shuffle)
```

    ## <environment: 0x7fbae17bd928>

> This arrangement is called a closure. setup’s runtime environment
> “encloses” the deal and shuffle functions. Both deal and shuffle can
> work closely with the objects contained in the enclosing environment,
> but almost nothing else can. The enclosing environment is not on the
> search path for any other R function or environment.

But these functions still modify `deck` and `DECK` in the global
environment, another change is needed to solve this:

``` r
setup <- function(deck) {
  DECK <- deck

  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = parent.env(environment()))
    card
  }

  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = parent.env(environment()))
 }

  list(deal = DEAL, shuffle = SHUFFLE)
}

cards <- setup(deck)
deal <- cards$deal
shuffle <- cards$shuffle
```

Lets see what happen this time if `deck` is erased:

``` r
rm(deck)

shuffle()

deal()
```

    ##    face     suit value
    ## 36 four diamonds     4

> We finally have a self-contained card game\!
