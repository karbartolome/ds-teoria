Regresiones
================
Karina Bartolomé
2022-05-01

# Referencias

<https://bookdown.org/roback/bookdown-BeyondMLR/ch-MLRreview.html>

``` r
library(dplyr)
library(ggplot2)
library(gt)
library(AER)
library(performance)
```

Se utiliza el paquete `{AER}` 📦 (Applied Econometric with R), que
contiene un gran número de datasets econométricos.

En este caso, los datos contienen información sobre resultados
educativos,Stock & Watson (2007). Incluyen características
sociodemográficas de estudiantes y escuelas en distritos de California.

``` r
#data(package='AER') # Lista los datasets disponibles en el paquete AER
```

Se cargan los datos:

``` r
data("CASchools")
```

![](03_regresion_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

<img src="eda.png" width="70%" style="display: block; margin: auto;" />

# Algunos conceptos vinculados a regresiones

# 1. Regresión lineal

En esta sección se estima un modelo de regresión linal univariado,
definido como:

![\hat{Y} = \alpha + \beta_1 X_1](https://latex.codecogs.com/png.latex?%5Chat%7BY%7D%20%3D%20%5Calpha%20%2B%20%5Cbeta_1%20X_1 "\hat{Y} = \alpha + \beta_1 X_1")

Donde Y es la variable a predecir y X una variable independiente.

Se busca estimar el efecto de **lunch** sobre **math**:

``` r
modelo_reg_lineal <- lm(math ~ lunch, data=CASchools)
```

Con `{equatiomatic}` 📦 se visualiza la ecuación del modelo:

``` r
equatiomatic::extract_eq(modelo_reg_lineal)
```

![\operatorname{math} = {\color{black}{\alpha}} + {\color{red}{\beta}}\_{{\color{red}{1}}}(\operatorname{lunch}) + {\color{black}{\epsilon}}](https://latex.codecogs.com/png.latex?%5Coperatorname%7Bmath%7D%20%3D%20%7B%5Ccolor%7Bblack%7D%7B%5Calpha%7D%7D%20%2B%20%7B%5Ccolor%7Bred%7D%7B%5Cbeta%7D%7D_%7B%7B%5Ccolor%7Bred%7D%7B1%7D%7D%7D%28%5Coperatorname%7Blunch%7D%29%20%2B%20%7B%5Ccolor%7Bblack%7D%7B%5Cepsilon%7D%7D "\operatorname{math} = {\color{black}{\alpha}} + {\color{red}{\beta}}_{{\color{red}{1}}}(\operatorname{lunch}) + {\color{black}{\epsilon}}")

También es posible visualizar la regresión lineal estimada (con los
coeficientes correspondientes):

``` r
equatiomatic::extract_eq(modelo_reg_lineal, 
                         use_coefs=TRUE) 
```

![\operatorname{\widehat{math}} = 678.78 - 0.57(\operatorname{lunch})](https://latex.codecogs.com/png.latex?%5Coperatorname%7B%5Cwidehat%7Bmath%7D%7D%20%3D%20678.78%20-%200.57%28%5Coperatorname%7Blunch%7D%29 "\operatorname{\widehat{math}} = 678.78 - 0.57(\operatorname{lunch})")

El error de estimación es la diferencia entre el valor observado y el
valor predicho:

![\operatorname{math} - \operatorname{\widehat{math}} = \epsilon](https://latex.codecogs.com/png.latex?%5Coperatorname%7Bmath%7D%20-%20%5Coperatorname%7B%5Cwidehat%7Bmath%7D%7D%20%3D%20%5Cepsilon "\operatorname{math} - \operatorname{\widehat{math}} = \epsilon")

Visualmente:

![](03_regresion_files/figure-gfm/plot_reg_fit-1.png)<!-- -->

![](03_regresion_files/figure-gfm/plot_reg_pred-1.png)<!-- -->

## 1.1: Supuestos para regresión lineal

``` r
performance::check_model(modelo_reg_lineal)
```

![](03_regresion_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

------------------------------------------------------------------------

# 2. Regresión lineal multivariada

Ahora se consideran N variables independientes:

![\hat{Y} = \alpha + \beta_1 X_1 + ... + \beta_n X_n](https://latex.codecogs.com/png.latex?%5Chat%7BY%7D%20%3D%20%5Calpha%20%2B%20%5Cbeta_1%20X_1%20%2B%20...%20%2B%20%5Cbeta_n%20X_n "\hat{Y} = \alpha + \beta_1 X_1 + ... + \beta_n X_n")

``` r
modelo_reg_lineal_multiple <- lm(math ~ lunch+income+students, data=CASchools)
```

Con `{equatiomatic}` 📦 se visualiza la ecuación del modelo:

``` r
equatiomatic::extract_eq(modelo_reg_lineal_multiple)
```

![\operatorname{math} = \alpha + \beta\_{1}(\operatorname{lunch}) + \beta\_{2}(\operatorname{income}) + \beta\_{3}(\operatorname{students}) + \epsilon](https://latex.codecogs.com/png.latex?%5Coperatorname%7Bmath%7D%20%3D%20%5Calpha%20%2B%20%5Cbeta_%7B1%7D%28%5Coperatorname%7Blunch%7D%29%20%2B%20%5Cbeta_%7B2%7D%28%5Coperatorname%7Bincome%7D%29%20%2B%20%5Cbeta_%7B3%7D%28%5Coperatorname%7Bstudents%7D%29%20%2B%20%5Cepsilon "\operatorname{math} = \alpha + \beta_{1}(\operatorname{lunch}) + \beta_{2}(\operatorname{income}) + \beta_{3}(\operatorname{students}) + \epsilon")

También es posible visualizar la regresión lineal estimada (con los
coeficientes correspondientes):

``` r
equatiomatic::extract_eq(modelo_reg_lineal_multiple, 
                         use_coefs=TRUE) 
```

![\operatorname{\widehat{math}} = 663.02 - 0.44(\operatorname{lunch}) + 0.69(\operatorname{income}) + 0(\operatorname{students})](https://latex.codecogs.com/png.latex?%5Coperatorname%7B%5Cwidehat%7Bmath%7D%7D%20%3D%20663.02%20-%200.44%28%5Coperatorname%7Blunch%7D%29%20%2B%200.69%28%5Coperatorname%7Bincome%7D%29%20%2B%200%28%5Coperatorname%7Bstudents%7D%29 "\operatorname{\widehat{math}} = 663.02 - 0.44(\operatorname{lunch}) + 0.69(\operatorname{income}) + 0(\operatorname{students})")

# 3. GLM: Generalized linear models

Para casos en los cuales no se cumple el supuesto de normalidad de la
variable Y (outcome).

## 3.1: Regresión logística (outcome binario)

Y \~ Binomial()

## 3.2: Regresión de Poisson (conteo)

Y \~ Poisson()
