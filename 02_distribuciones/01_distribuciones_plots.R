library(tidyverse)
library(extrafont)
library(patchwork)

source(here::here('','functions/distribuciones.R'))

# Distribución normal
p1<-gen_rand_distributions(.distribution_random  = rnorm,
                           .distribution_density = dnorm,
                           .n_obs=100, .n_samples=10, mean=0, sd=1)

# Distribución chi-cuadrado
p2<-gen_rand_distributions(.distribution_random  = rchisq, 
                           .distribution_density = dchisq,
                           .n_obs=50, .n_samples=15, df=3)

# Distribución exponencial
p3<-gen_rand_distributions(.distribution_random  = rexp, 
                           .distribution_density = dexp,
                           .n_obs=25, .n_samples=10, rate=1)

# Distribución gamma
p4<-gen_rand_distributions(.distribution_random  = rgamma, 
                           .distribution_density = dgamma,
                           .n_obs=100, .n_samples=5, shape=2)

# Gráficos combinadods en uno único
(p1+p2)/(p3+p4)

ggsave(here::here('02_distribuciones/distribuciones.png'))
