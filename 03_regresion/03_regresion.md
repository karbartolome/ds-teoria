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

``` r
data("CreditCard")
```

``` r
modelo_reg_logistica <- glm(factor(reports > 0) ~ age + income + owner,
                            data = CreditCard, 
                            family = binomial)
```

``` r
equatiomatic::extract_eq(modelo_reg_logistica)
```

![\log\left\[ \frac { P( \operatorname{reports} = \operatorname{7} ) }{ 1 - P( \operatorname{reports} = \operatorname{7} ) } \right\] = \alpha + \beta\_{1}(\operatorname{age}) + \beta\_{2}(\operatorname{income}) + \beta\_{3}(\operatorname{owner}\_{\operatorname{yes}})](https://latex.codecogs.com/png.latex?%5Clog%5Cleft%5B%20%5Cfrac%20%7B%20P%28%20%5Coperatorname%7Breports%7D%20%3D%20%5Coperatorname%7B7%7D%20%29%20%7D%7B%201%20-%20P%28%20%5Coperatorname%7Breports%7D%20%3D%20%5Coperatorname%7B7%7D%20%29%20%7D%20%5Cright%5D%20%3D%20%5Calpha%20%2B%20%5Cbeta_%7B1%7D%28%5Coperatorname%7Bage%7D%29%20%2B%20%5Cbeta_%7B2%7D%28%5Coperatorname%7Bincome%7D%29%20%2B%20%5Cbeta_%7B3%7D%28%5Coperatorname%7Bowner%7D_%7B%5Coperatorname%7Byes%7D%7D%29 "\log\left[ \frac { P( \operatorname{reports} = \operatorname{7} ) }{ 1 - P( \operatorname{reports} = \operatorname{7} ) } \right] = \alpha + \beta_{1}(\operatorname{age}) + \beta_{2}(\operatorname{income}) + \beta_{3}(\operatorname{owner}_{\operatorname{yes}})")

``` r
equatiomatic::extract_eq(modelo_reg_logistica, use_coefs=TRUE)
```

![\log\left\[ \frac { \widehat{P( \operatorname{reports} = \operatorname{7} )} }{ 1 - \widehat{P( \operatorname{reports} = \operatorname{7} )} } \right\] = -2.24 + 0.02(\operatorname{age}) + 0.07(\operatorname{income}) - 0.38(\operatorname{owner}\_{\operatorname{yes}})](https://latex.codecogs.com/png.latex?%5Clog%5Cleft%5B%20%5Cfrac%20%7B%20%5Cwidehat%7BP%28%20%5Coperatorname%7Breports%7D%20%3D%20%5Coperatorname%7B7%7D%20%29%7D%20%7D%7B%201%20-%20%5Cwidehat%7BP%28%20%5Coperatorname%7Breports%7D%20%3D%20%5Coperatorname%7B7%7D%20%29%7D%20%7D%20%5Cright%5D%20%3D%20-2.24%20%2B%200.02%28%5Coperatorname%7Bage%7D%29%20%2B%200.07%28%5Coperatorname%7Bincome%7D%29%20-%200.38%28%5Coperatorname%7Bowner%7D_%7B%5Coperatorname%7Byes%7D%7D%29 "\log\left[ \frac { \widehat{P( \operatorname{reports} = \operatorname{7} )} }{ 1 - \widehat{P( \operatorname{reports} = \operatorname{7} )} } \right] = -2.24 + 0.02(\operatorname{age}) + 0.07(\operatorname{income}) - 0.38(\operatorname{owner}_{\operatorname{yes}})")

``` r
gtsummary::tbl_regression(
  modelo_reg_logistica,
  intercept = TRUE
  ) %>%  gtsummary::as_kable()
```

| **Characteristic** | **log(OR)** | **95% CI**   | **p-value** |
|:-------------------|:------------|:-------------|:------------|
| (Intercept)        | -2.2        | -2.7, -1.8   | \<0.001     |
| age                | 0.02        | 0.01, 0.04   | 0.002       |
| income             | 0.07        | -0.01, 0.15  | 0.10        |
| owner              |             |              |             |
| no                 |             |              |             |
| yes                | -0.38       | -0.69, -0.07 | 0.017       |

## 3.2: Regresión de Poisson (conteo)

Y \~ Poisson()

``` r
modelo_reg_poisson <- glm(reports ~ age + income + expenditure, 
                          data = CreditCard, family = poisson)
summary(modelo_reg_poisson)
```

    ## 
    ## Call:
    ## glm(formula = reports ~ age + income + expenditure, family = poisson, 
    ##     data = CreditCard)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.7427  -1.0689  -0.8390  -0.3897   7.4991  
    ## 
    ## Coefficients:
    ##              Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -0.819682   0.145272  -5.642 1.68e-08 ***
    ## age          0.007181   0.003978   1.805  0.07105 .  
    ## income       0.077898   0.023940   3.254  0.00114 ** 
    ## expenditure -0.004102   0.000374 -10.968  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for poisson family taken to be 1)
    ## 
    ##     Null deviance: 2347.4  on 1318  degrees of freedom
    ## Residual deviance: 2143.9  on 1315  degrees of freedom
    ## AIC: 2801.4
    ## 
    ## Number of Fisher Scoring iterations: 7

``` r
equatiomatic::extract_eq(modelo_reg_poisson)
```

![\log ({ E( \operatorname{reports} ) })  = \alpha + \beta\_{1}(\operatorname{age}) + \beta\_{2}(\operatorname{income}) + \beta\_{3}(\operatorname{expenditure})](https://latex.codecogs.com/png.latex?%5Clog%20%28%7B%20E%28%20%5Coperatorname%7Breports%7D%20%29%20%7D%29%20%20%3D%20%5Calpha%20%2B%20%5Cbeta_%7B1%7D%28%5Coperatorname%7Bage%7D%29%20%2B%20%5Cbeta_%7B2%7D%28%5Coperatorname%7Bincome%7D%29%20%2B%20%5Cbeta_%7B3%7D%28%5Coperatorname%7Bexpenditure%7D%29 "\log ({ E( \operatorname{reports} ) })  = \alpha + \beta_{1}(\operatorname{age}) + \beta_{2}(\operatorname{income}) + \beta_{3}(\operatorname{expenditure})")

``` r
equatiomatic::extract_eq(modelo_reg_poisson, use_coefs=TRUE)
```

![\log ({ \widehat{E( \operatorname{reports} )} })  = -0.82 + 0.01(\operatorname{age}) + 0.08(\operatorname{income}) + 0(\operatorname{expenditure})](https://latex.codecogs.com/png.latex?%5Clog%20%28%7B%20%5Cwidehat%7BE%28%20%5Coperatorname%7Breports%7D%20%29%7D%20%7D%29%20%20%3D%20-0.82%20%2B%200.01%28%5Coperatorname%7Bage%7D%29%20%2B%200.08%28%5Coperatorname%7Bincome%7D%29%20%2B%200%28%5Coperatorname%7Bexpenditure%7D%29 "\log ({ \widehat{E( \operatorname{reports} )} })  = -0.82 + 0.01(\operatorname{age}) + 0.08(\operatorname{income}) + 0(\operatorname{expenditure})")

``` r
gtsummary::tbl_regression(
  modelo_reg_poisson,
  intercept = TRUE
  ) %>% gtsummary::as_kable()
```

| **Characteristic** | **log(IRR)** | **95% CI**  | **p-value** |
|:-------------------|:-------------|:------------|:------------|
| (Intercept)        | -0.82        | -1.1, -0.54 | \<0.001     |
| age                | 0.01         | 0.00, 0.01  | 0.071       |
| income             | 0.08         | 0.03, 0.12  | 0.001       |
| expenditure        | 0.00         | 0.00, 0.00  | \<0.001     |
