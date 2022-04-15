Matrices
================

# Matrices en R

Matriz identidad:

``` r
I = diag(3)
I
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    0    0
    ## [2,]    0    1    0
    ## [3,]    0    0    1

# Cálculo de autovalores (eigenvalues)

A x = λ x

A x−λ x = 0  
( A − λ I ) x = 0

\| A − λ I \| = 0 –\> Ecuación característica

``` r
A <- t(matrix(c(1, 1, -2,
              -1, 2, 1,
              0, 1, -1), 
            nrow = 3, ncol = 3))
A
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    1   -2
    ## [2,]   -1    2    1
    ## [3,]    0    1   -1

Si λ = 0 =\> A - 0 \* I :

``` r
lambda = 0
A - lambda * I
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    1   -2
    ## [2,]   -1    2    1
    ## [3,]    0    1   -1

Calculando el determinante \| A − λ I \|

``` r
det(A - lambda*I)
```

    ## [1] -2

No es igual a 0, con lo cual λ = 0 no es un autovalor de la matriz A.

Calculando los autovalores que resuelvan la ecuación luego de la
expansión de Laplace:

``` r
eigen(A)$values
```

    ## [1]  2  1 -1

Notar que si se hace:

``` r
det(A - 2*I)
```

    ## [1] 0

# Cálculo de autovectores
