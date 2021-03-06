Distribuciones
================
Karina Bartolomé

``` r
library(tidyverse)

source(here::here('','functions/distribuciones.R'))
```

``` r
N         = 100
N_samples = 3
```

# Distribuciones

En R base existen funciones asociadas a distribuciones. Cada
distribución tiene 4 funciones asociadas:

-   **d**:Función de densidad/probabilidad

-   **p**: Función de distribución acumulada

-   **q**: Función inversa de la distribución acumulada

-   **r**:Función para generar variables aleatorias

# 1. Normal

``` r
valores <- seq(from=-5, to=5, by=0.1)

d_normal <- dnorm(valores, mean=0, sd=1)
p_normal <- pnorm(valores, mean=0, sd=1)
```

Se visualizan las distribuciones. Notar que en X=0 (media de la
distribución normal generada), la probabilidad acumulada es 0.5.

``` r
ggplot()+

  geom_line(aes(x=valores, y=d_normal, color='Densidad N(0,1)'))+
  geom_line(aes(x=valores, y=p_normal, color='Acumulada N(0,1)'))+
  
  labs(x='X', y='Probabilidad', 
       title='Distribución normal',
       substitle='Densidad, aleatoria y acumulada',
       color='Distribución'
  )
```

![](01_distribuciones_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

También es posible graficar la distribución normal con ggplot directo,
utilizando stat_function():

``` r
data.frame(x = c(-5, 5)) %>% 
  ggplot(aes(x = x)) +
    stat_function(fun = dnorm, 
                  n = N, 
                  args = list(mean = 0, sd = 1), 
                  aes(color='Distribución N(0,1)')) + 
    stat_function(fun = pnorm, 
                  n = N, 
                  args = list(mean = 0, sd = 1), 
                  aes(color='Acumulada N(0,1)')) + 
  
    labs(color='Distribución')
```

![](01_distribuciones_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

Se generan 3 distribuciones normales aleatorias, cada una con 10
observaciones:

``` r
r_random <- gen_rand_distributions(
                       .distribution_random = rnorm,
                       .distribution_density = dnorm,
                       .n_obs        = N,
                       .n_samples    = N_samples, .plot=FALSE,
                       mean = 0, sd = 1
                       )
```

``` r
r_random %>% 
  group_by(sample_number) %>% 
  summarise(mean=mean(value), sd=sd(value)) %>% 
  knitr::kable()
```

| sample_number |       mean |        sd |
|:--------------|-----------:|----------:|
| 1             |  0.0325148 | 1.0413570 |
| 2             | -0.0874837 | 0.9041735 |
| 3             | -0.0103682 | 1.0170123 |

``` r
ggplot()+
  
  geom_density(data=r_random, aes(x=value, color=sample_number))+
  
  geom_vline(xintercept=0)+
  
  labs(x='X', y='Probabilidad', 
       title='Distribución normal',
       substitle='Densidad, aleatoria y acumulada',
       color='Distribución'
  )
```

![](01_distribuciones_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

# Distribución Poisson

``` r
valores <- seq(from=0, to=10, by=1)
lambda = 5

d_poisson <- dpois(valores, lambda = lambda)
p_poisson <- ppois(valores, lambda = lambda)
```

``` r
ggplot()+
  
  geom_col(aes(x=factor(valores), y=d_poisson, 
               color='Densidad Poisson(1)',
               fill='Densidad Poisson(1)'), alpha=0.7)+
  geom_line(aes(x=valores, y=p_poisson, 
                color='Acumulada Poisson(1)', 
                fill='Acumulada Poisson(1)'))+

  labs(x='X', y='Probabilidad', 
       title='Distribución poisson',
       substitle='Densidad, aleatoria y acumulada',
       color='Distribución', fill='Distribución'
  )
```

![](01_distribuciones_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

``` r
r_poisson <- gen_rand_distributions(                                  
                       .distribution_random = rpois,
                       .distribution_density = dpois,
                       .n_obs=N,
                       .n_samples=N_samples, .plot=FALSE,
                       lambda=lambda)
```

``` r
ggplot()+
  geom_bar(data=r_poisson,
               aes(x=factor(value), fill=sample_number),
               position='dodge',
               alpha=0.7)+

  labs(x='Valor',y='Frecuencia',fill='Muestra',
       title = 'Distribución poisson aleatoria: \nFrecuencia de valores en cada muestra aleatoria',
       subtitle=paste0('Lambda=',lambda))
```

![](01_distribuciones_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

# Distribución Exponencial

``` r
rate = 1
d_expo <- dexp(valores, rate=rate)
p_expo <- pexp(valores, rate=rate)
```

``` r
ggplot()+
  
  geom_line(aes(x=valores, y=d_expo, color='Densidad Exp(1)'))+
  geom_line(aes(x=valores, y=p_expo, color='Acumulada Exp(1)'))+

  labs(x='X', y='Probabilidad', 
       title='Distribución Exponencial',
       substitle='Densidad, aleatoria y acumulada',
       color='Distribución'
  )
```

![](01_distribuciones_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

``` r
r_expo <- gen_rand_distributions(
                       .distribution_random = rexp,
                       .distribution_density = dexp,
                       .n_obs        = N,
                       .n_samples    = N_samples, .plot=FALSE,
                       rate = 1
                       )
```

``` r
ggplot()+
  
  geom_density(data=r_expo, aes(x=value, color=sample_number))+

  labs(x='X', y='Probabilidad', 
       title='Distribución exponencial random',
       color='Distribución'
  )
```

![](01_distribuciones_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

# Distribución Gamma

``` r
shape = 1
d_gamma <- dgamma(valores, shape=shape)
p_gamma <- pgamma(valores, shape=shape)
```

``` r
ggplot()+
  
  geom_line(aes(x=valores, y=d_expo, color='Densidad Gamma(1)'))+
  geom_line(aes(x=valores, y=p_expo, color='Acumulada Gamma(1)'))+

  labs(x='X', y='Probabilidad', 
       title='Distribución Gamma',
       substitle='Densidad, aleatoria y acumulada',
       color='Distribución'
  )
```

![](01_distribuciones_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

``` r
r_gamma <- gen_rand_distributions(
                       .distribution_random = rgamma,
                       .distribution_density = dgamma,
                       .n_obs        = N,
                       .n_samples    = N_samples, .plot=FALSE,
                       shape = shape
                       )
```

``` r
ggplot()+
  
  geom_density(data=r_gamma, aes(x=value, color=sample_number))+

  labs(x='X', y='Probabilidad', 
       title='Distribución gamma random',
       color='Distribución'
  )
```

![](01_distribuciones_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

# Distribución Chi-Cuadrado

``` r
grados = 2
d_chi <- dchisq(valores, df=grados)
p_chi <- pchisq(valores, df=grados)
```

``` r
ggplot()+
  
  geom_line(aes(x=valores, y=d_chi, color='Densidad Chi(df=2)'))+
  geom_line(aes(x=valores, y=p_chi, color='Acumulada Chi(df=2)'))+

  labs(x='X', y='Probabilidad', 
       title='Distribución Chi-Cuadrado',
       substitle='Densidad, aleatoria y acumulada',
       color='Distribución'
  )
```

![](01_distribuciones_files/figure-gfm/unnamed-chunk-23-1.png)<!-- -->

``` r
r_chi <- gen_rand_distributions(
                       .distribution_random = rchisq,
                       .distribution_density=dchisq,
                       .n_obs        = N,
                       .n_samples    = N_samples, .plot=FALSE,
                       df = grados
                       )
```

``` r
ggplot()+
  
  geom_density(data=r_chi, aes(x=value, color=sample_number))+
  
  labs(x='X', y='Probabilidad', 
       title='Distribución Chi Cuadrado random',
       color='Distribución'
  )
```

![](01_distribuciones_files/figure-gfm/unnamed-chunk-25-1.png)<!-- -->

``` r
knitr::knit_exit()
```
