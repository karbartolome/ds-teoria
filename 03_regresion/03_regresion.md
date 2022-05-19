Regresiones
================
Karina Bartolomé
2022-05-01

-   <a href="#referencias" id="toc-referencias">Referencias</a>
-   <a href="#algunos-conceptos-vinculados-a-regresiones"
    id="toc-algunos-conceptos-vinculados-a-regresiones">Algunos conceptos
    vinculados a regresiones</a>
-   <a href="#1-regresión-lineal" id="toc-1-regresión-lineal">1. Regresión
    lineal</a>
    -   <a href="#11-supuestos-para-regresión-lineal"
        id="toc-11-supuestos-para-regresión-lineal">1.1: Supuestos para
        regresión lineal</a>
-   <a href="#2-regresión-lineal-multivariada"
    id="toc-2-regresión-lineal-multivariada">2. Regresión lineal
    multivariada</a>
-   <a href="#3-glm-generalized-linear-models"
    id="toc-3-glm-generalized-linear-models">3. GLM: Generalized linear
    models</a>
    -   <a href="#31-regresión-logística-outcome-binario"
        id="toc-31-regresión-logística-outcome-binario">3.1: Regresión logística
        (outcome binario)</a>
    -   <a href="#32-regresión-de-poisson-conteo"
        id="toc-32-regresión-de-poisson-conteo">3.2: Regresión de Poisson
        (conteo)</a>

# Referencias

<https://bookdown.org/roback/bookdown-BeyondMLR/ch-MLRreview.html>

``` r
library(tidyverse)
library(gt)
library(AER)
library(performance)

theme_set(theme_minimal())
```

Se utiliza el paquete `{AER}` :package: (Applied Econometric with R),
que contiene un gran número de datasets econométricos.

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

![\hat{Y} = \alpha + \beta_1 X_1](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7BY%7D%20%3D%20%5Calpha%20%2B%20%5Cbeta_1%20X_1 "\hat{Y} = \alpha + \beta_1 X_1")

Donde Y es la variable a predecir y X una variable independiente.

Se busca estimar el efecto de **lunch** sobre **math**:

``` r
modelo_reg_lineal <- lm(math ~ lunch, data=CASchools)
```

Con `{equatiomatic}` :package: se visualiza la ecuación del modelo:

``` r
eq <- equatiomatic::extract_eq(modelo_reg_lineal)
eq
```

![\operatorname{math} = \alpha + \beta\_{1}(\operatorname{lunch}) + \epsilon](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Coperatorname%7Bmath%7D%20%3D%20%5Calpha%20%2B%20%5Cbeta_%7B1%7D%28%5Coperatorname%7Blunch%7D%29%20%2B%20%5Cepsilon "\operatorname{math} = \alpha + \beta_{1}(\operatorname{lunch}) + \epsilon")

También es posible visualizar la regresión lineal estimada (con los
coeficientes correspondientes):

``` r
eq <- equatiomatic::extract_eq(modelo_reg_lineal, 
                         use_coefs=TRUE) 

eq
```

![\operatorname{\widehat{math}} = 678.78 - 0.57(\operatorname{lunch})](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Coperatorname%7B%5Cwidehat%7Bmath%7D%7D%20%3D%20678.78%20-%200.57%28%5Coperatorname%7Blunch%7D%29 "\operatorname{\widehat{math}} = 678.78 - 0.57(\operatorname{lunch})")

El error de estimación es la diferencia entre el valor observado y el
valor predicho:

![\operatorname{math} - \operatorname{\widehat{math}} = \epsilon](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Coperatorname%7Bmath%7D%20-%20%5Coperatorname%7B%5Cwidehat%7Bmath%7D%7D%20%3D%20%5Cepsilon "\operatorname{math} - \operatorname{\widehat{math}} = \epsilon")

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

![\hat{Y} = \alpha + \beta_1 X_1 + ... + \beta_n X_n](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Chat%7BY%7D%20%3D%20%5Calpha%20%2B%20%5Cbeta_1%20X_1%20%2B%20...%20%2B%20%5Cbeta_n%20X_n "\hat{Y} = \alpha + \beta_1 X_1 + ... + \beta_n X_n")

``` r
modelo_reg_lineal_multiple <- lm(math ~ lunch+income+students, data=CASchools)
```

Con `{equatiomatic}` :package: se visualiza la ecuación del modelo:

``` r
equatiomatic::extract_eq(modelo_reg_lineal_multiple)
```

![\operatorname{math} = \alpha + \beta\_{1}(\operatorname{lunch}) + \beta\_{2}(\operatorname{income}) + \beta\_{3}(\operatorname{students}) + \epsilon](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Coperatorname%7Bmath%7D%20%3D%20%5Calpha%20%2B%20%5Cbeta_%7B1%7D%28%5Coperatorname%7Blunch%7D%29%20%2B%20%5Cbeta_%7B2%7D%28%5Coperatorname%7Bincome%7D%29%20%2B%20%5Cbeta_%7B3%7D%28%5Coperatorname%7Bstudents%7D%29%20%2B%20%5Cepsilon "\operatorname{math} = \alpha + \beta_{1}(\operatorname{lunch}) + \beta_{2}(\operatorname{income}) + \beta_{3}(\operatorname{students}) + \epsilon")

También es posible visualizar la regresión lineal estimada (con los
coeficientes correspondientes):

``` r
equatiomatic::extract_eq(modelo_reg_lineal_multiple, 
                         use_coefs=TRUE) 
```

![\operatorname{\widehat{math}} = 663.02 - 0.44(\operatorname{lunch}) + 0.69(\operatorname{income}) + 0(\operatorname{students})](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Coperatorname%7B%5Cwidehat%7Bmath%7D%7D%20%3D%20663.02%20-%200.44%28%5Coperatorname%7Blunch%7D%29%20%2B%200.69%28%5Coperatorname%7Bincome%7D%29%20%2B%200%28%5Coperatorname%7Bstudents%7D%29 "\operatorname{\widehat{math}} = 663.02 - 0.44(\operatorname{lunch}) + 0.69(\operatorname{income}) + 0(\operatorname{students})")

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

![\log\left\[ \frac { P( \operatorname{reports} = \operatorname{7} ) }{ 1 - P( \operatorname{reports} = \operatorname{7} ) } \right\] = \alpha + \beta\_{1}(\operatorname{age}) + \beta\_{2}(\operatorname{income}) + \beta\_{3}(\operatorname{owner}\_{\operatorname{yes}})](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Clog%5Cleft%5B%20%5Cfrac%20%7B%20P%28%20%5Coperatorname%7Breports%7D%20%3D%20%5Coperatorname%7B7%7D%20%29%20%7D%7B%201%20-%20P%28%20%5Coperatorname%7Breports%7D%20%3D%20%5Coperatorname%7B7%7D%20%29%20%7D%20%5Cright%5D%20%3D%20%5Calpha%20%2B%20%5Cbeta_%7B1%7D%28%5Coperatorname%7Bage%7D%29%20%2B%20%5Cbeta_%7B2%7D%28%5Coperatorname%7Bincome%7D%29%20%2B%20%5Cbeta_%7B3%7D%28%5Coperatorname%7Bowner%7D_%7B%5Coperatorname%7Byes%7D%7D%29 "\log\left[ \frac { P( \operatorname{reports} = \operatorname{7} ) }{ 1 - P( \operatorname{reports} = \operatorname{7} ) } \right] = \alpha + \beta_{1}(\operatorname{age}) + \beta_{2}(\operatorname{income}) + \beta_{3}(\operatorname{owner}_{\operatorname{yes}})")

``` r
equatiomatic::extract_eq(modelo_reg_logistica, use_coefs=TRUE)
```

![\log\left\[ \frac { \widehat{P( \operatorname{reports} = \operatorname{7} )} }{ 1 - \widehat{P( \operatorname{reports} = \operatorname{7} )} } \right\] = -2.24 + 0.02(\operatorname{age}) + 0.07(\operatorname{income}) - 0.38(\operatorname{owner}\_{\operatorname{yes}})](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Clog%5Cleft%5B%20%5Cfrac%20%7B%20%5Cwidehat%7BP%28%20%5Coperatorname%7Breports%7D%20%3D%20%5Coperatorname%7B7%7D%20%29%7D%20%7D%7B%201%20-%20%5Cwidehat%7BP%28%20%5Coperatorname%7Breports%7D%20%3D%20%5Coperatorname%7B7%7D%20%29%7D%20%7D%20%5Cright%5D%20%3D%20-2.24%20%2B%200.02%28%5Coperatorname%7Bage%7D%29%20%2B%200.07%28%5Coperatorname%7Bincome%7D%29%20-%200.38%28%5Coperatorname%7Bowner%7D_%7B%5Coperatorname%7Byes%7D%7D%29 "\log\left[ \frac { \widehat{P( \operatorname{reports} = \operatorname{7} )} }{ 1 - \widehat{P( \operatorname{reports} = \operatorname{7} )} } \right] = -2.24 + 0.02(\operatorname{age}) + 0.07(\operatorname{income}) - 0.38(\operatorname{owner}_{\operatorname{yes}})")

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

Siendo Y el número de eventos que ocurren en un determinado tiempo, Y
puede ser modelado mediante una distribución de Poisson:

![P(Y=y)=\frac{e^{-λ}λ^{y}}{y!}, \\ y=0,1,2,…,∞](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;P%28Y%3Dy%29%3D%5Cfrac%7Be%5E%7B-%CE%BB%7D%CE%BB%5E%7By%7D%7D%7By%21%7D%2C%20%5C%20y%3D0%2C1%2C2%2C%E2%80%A6%2C%E2%88%9E "P(Y=y)=\frac{e^{-λ}λ^{y}}{y!}, \ y=0,1,2,…,∞")

Propiedades de la distribución de Poisson:

-   E(Y) = Var(Y) =
    ![\lambda](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Clambda "\lambda")

-   Usualmente sesgada a la derecha, particularmente para
    ![\lambda](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Clambda "\lambda")
    chico

-   A medida que
    ![\lambda](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Clambda "\lambda")
    aumenta, la distribución se vuelve más simétrica.
    Si![\lambda](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Clambda "\lambda")
    es lo suficientemente grande, Y se puede aproximar con una
    distribución normal.

``` r
data.frame(x=c(0:10)) %>% 
  mutate(`1`=dpois(x,1), 
         `2`=dpois(x,2),
         `5`=dpois(x,5), 
         `10`=dpois(x,10)) %>% 
  pivot_longer(cols=-x, names_to='lambda') %>%
  mutate(lambda = as.integer(lambda)) %>% 
  ggplot(aes(x=factor(x), y=value, fill=factor(lambda)))+
  geom_col(position='dodge', show.legend=FALSE)+
  facet_wrap(~lambda, nrow = 4)+
  labs(x='x',y='Densidad',
       title='Distribuciones Poisson',
       subtitle='Distintos valores de lambda')
```

![](03_regresion_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

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

![\log ({ E( \operatorname{reports} ) })  = \alpha + \beta\_{1}(\operatorname{age}) + \beta\_{2}(\operatorname{income}) + \beta\_{3}(\operatorname{\expenditure})](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Clog%20%28%7B%20E%28%20%5Coperatorname%7Breports%7D%20%29%20%7D%29%20%20%3D%20%5Calpha%20%2B%20%5Cbeta_%7B1%7D%28%5Coperatorname%7Bage%7D%29%20%2B%20%5Cbeta_%7B2%7D%28%5Coperatorname%7Bincome%7D%29%20%2B%20%5Cbeta_%7B3%7D%28%5Coperatorname%7B%5Cexpenditure%7D%29 "\log ({ E( \operatorname{reports} ) })  = \alpha + \beta_{1}(\operatorname{age}) + \beta_{2}(\operatorname{income}) + \beta_{3}(\operatorname{\expenditure})")

``` r
equatiomatic::extract_eq(modelo_reg_poisson, use_coefs=TRUE)
```

![\log ({ \widehat{E( \operatorname{reports} )} })  = -0.82 + 0.01(\operatorname{age}) + 0.08(\operatorname{income}) + 0(\operatorname{\expenditure})](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Clog%20%28%7B%20%5Cwidehat%7BE%28%20%5Coperatorname%7Breports%7D%20%29%7D%20%7D%29%20%20%3D%20-0.82%20%2B%200.01%28%5Coperatorname%7Bage%7D%29%20%2B%200.08%28%5Coperatorname%7Bincome%7D%29%20%2B%200%28%5Coperatorname%7B%5Cexpenditure%7D%29 "\log ({ \widehat{E( \operatorname{reports} )} })  = -0.82 + 0.01(\operatorname{age}) + 0.08(\operatorname{income}) + 0(\operatorname{\expenditure})")

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
