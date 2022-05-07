Untitled
================
Karina Bartolomé
2022-05-07

``` r
modelo <- lm(Sepal.Length ~ Petal.Length, data=iris)
```

![\operatorname{\widehat{math}} = 678.78 - 0.57(\operatorname{lunch})](https://latex.codecogs.com/png.latex?%5Coperatorname%7B%5Cwidehat%7Bmath%7D%7D%20%3D%20678.78%20-%200.57%28%5Coperatorname%7Blunch%7D%29 "\operatorname{\widehat{math}} = 678.78 - 0.57(\operatorname{lunch})")

![\operatorname{\widehat{math}} = 678.78 - 0.57(\operatorname{lunch})](https://latex.codecogs.com/png.latex?%5Coperatorname%7B%5Cwidehat%7Bmath%7D%7D%20%3D%20678.78%20-%200.57%28%5Coperatorname%7Blunch%7D%29 "\operatorname{\widehat{math}} = 678.78 - 0.57(\operatorname{lunch})")

``` r
eq <- equatiomatic::extract_eq(modelo, use_coefs = TRUE)
cat(paste0('$',eq,'$'))
```

![\operatorname{\widehat{Sepal.Length}} = 4.31 + 0.41(\operatorname{Petal.Length})](https://latex.codecogs.com/png.latex?%5Coperatorname%7B%5Cwidehat%7BSepal.Length%7D%7D%20%3D%204.31%20%2B%200.41%28%5Coperatorname%7BPetal.Length%7D%29 "\operatorname{\widehat{Sepal.Length}} = 4.31 + 0.41(\operatorname{Petal.Length})")

``` r
cat(paste0('$',gsub('widehat','',eq),'$'))
```

![\operatorname{\\{Sepal.Length}} = 4.31 + 0.41(\operatorname{Petal.Length})](https://latex.codecogs.com/png.latex?%5Coperatorname%7B%5C%7BSepal.Length%7D%7D%20%3D%204.31%20%2B%200.41%28%5Coperatorname%7BPetal.Length%7D%29 "\operatorname{\{Sepal.Length}} = 4.31 + 0.41(\operatorname{Petal.Length})")

``` r
eq <- equatiomatic::extract_eq(modelo, use_coefs = FALSE)
cat(eq)
```

    ## \operatorname{Sepal.Length} = \alpha + \beta_{1}(\operatorname{Petal.Length}) + \epsilon

``` r
cat(paste0('$',eq,'$'))
```

![\operatorname{Sepal.Length} = \alpha + \beta\_{1}(\operatorname{Petal.Length}) + \epsilon](https://latex.codecogs.com/png.latex?%5Coperatorname%7BSepal.Length%7D%20%3D%20%5Calpha%20%2B%20%5Cbeta_%7B1%7D%28%5Coperatorname%7BPetal.Length%7D%29%20%2B%20%5Cepsilon "\operatorname{Sepal.Length} = \alpha + \beta_{1}(\operatorname{Petal.Length}) + \epsilon")

![\hat{hola}](https://latex.codecogs.com/png.latex?%5Chat%7Bhola%7D "\hat{hola}")

``` math
\hat(x)
```
