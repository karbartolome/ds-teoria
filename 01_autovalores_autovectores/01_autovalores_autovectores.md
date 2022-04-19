Autovalores y autovectores
================
Karina Bartolomé

# Matrices en R:

Matriz identidad de 2x2:

    ##      [,1] [,2]
    ## [1,]    1    0
    ## [2,]    0    1

Se define una matriz A (m x n):

``` r
A <- t(matrix(c(0, 2, 
                2, 4), 
              nrow = 2, ncol = 2))
A
```

    ##      [,1] [,2]
    ## [1,]    0    2
    ## [2,]    2    4

Gráficamente:

![](01_autovalores_autovectores_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

# Autovalores y autovectores

Dados

*A* ∈ *𝚁*<sub>*n**x**n*</sub> , *λ* ∈ *𝚁* , *V* ∈ *𝚁*<sub>*n**x*1</sub>

Se dice que **λ** es un **autovalor** de A si y sólo si existe un vector
**V** (**autovector**) no nulo tal que:

A x = λ x

# Cálculo de autovalores (eigenvalues)

Existen tantos autovalores como número de filas (m) o columnas (n) tiene
la matriz original.

A x−λ x = 0

( A − λ I ) x = 0

\| A − λ I \| = 0 –\> **Ecuación característica de la matriz A**

En donde

p(λ)=\|A–λI\| es un polinomio de grado n dependiente de λ –\>
**polinomio característico de la matriz** A**A**

------------------------------------------------------------------------

Si λ = 2 =\> A - 2 \* I :

    ##      [,1] [,2]
    ## [1,]   -2    2
    ## [2,]    2    2

Calculando el determinante \| A − λ I \|

    ## [1] -8

No es igual a 0, con lo cual λ = 2 no es un autovalor de la matriz A.

Calculando los autovalores que resuelvan la ecuación:

``` r
autovalores <- eigen(A)$values
autovalores
```

    ## [1]  4.8284271 -0.8284271

Notar que si se calcula el determinante \| A − λ I \| para estos
autovalores da 0:

``` r
det(A - autovalores[1]*I)
```

    ## [1] -1.608189e-15

``` r
det(A - autovalores[2]*I)
```

    ## [1] 0

# Cálculo de autovectores

Autovectores:

``` r
autovectores <- eigen(A)$vectors
autovectores
```

    ##           [,1]       [,2]
    ## [1,] 0.3826834 -0.9238795
    ## [2,] 0.9238795  0.3826834

# Volviendo a A x = λ x

``` r
round(A %*% autovectores[,1],3) == round(matrix(autovectores[,1] * 
                                            autovalores[1], nrow=2),3)
```

    ##      [,1]
    ## [1,] TRUE
    ## [2,] TRUE

A x :

``` r
AX1 = A %*% autovectores[1,]
AX2 = A %*% autovectores[2,]
```

λ x :

``` r
X1L1 = autovectores[1,] * autovalores[1]
X2L2 = autovectores[2,] * autovalores[2]
```

``` r
print(X1L1)
```

    ## [1]  1.847759 -4.460885

``` r
print(AX2)
```

    ##           [,1]
    ## [1,] 0.7653669
    ## [2,] 3.3784928

``` r
print(X2L2)
```

    ## [1] -0.7653669 -0.3170253

``` r
print(AX1)
```

    ##           [,1]
    ## [1,] -1.847759
    ## [2,] -2.930151

# Gráficamente:

Visualizando el ejemplo de la matriz A. Se observa que se cumple la
igualdad A x = λ x. Además, se ve como AX1 = X1 \* un escalar (lambda 1)
y lo mismo para X2.

Además, cuando el autovalor es positivo, el vector se expande en la
misma dirección mientras que cuando el autovalor es negativo el vector
se expande en la dirección opuesta.

![](01_autovalores_autovectores_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

Considerando una matriz A distinta:

    ##      [,1] [,2]
    ## [1,]    3    1
    ## [2,]    2    4

![](01_autovalores_autovectores_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

Otro ejemplo:

    ##      [,1] [,2]
    ## [1,]    1    3
    ## [2,]    2    4

![](01_autovalores_autovectores_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->
