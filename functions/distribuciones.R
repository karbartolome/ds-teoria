#' gen_rand_distributions
#' @description Generar M replicas de una distribución, cada una con N observaciones
#' 
#' @param .distribution Distribución a utilizar. rnorm, rexp, rgamma, rbeta, rpois, rchisq
#' @param .n_obs Cantidad de observaciones en cada muestra
#' @param .n_samples : Cantidad de muestras a generar (replicas)
#' @param .seed : Semilla aleatoria 
#' @param ... : Parámetros de la distribución seleccionada
#'
#' @return
#' @export
#'
#' @examples
#' 
#' # Se generan 3 muestras de 1000 observaciones cada una, considerando una distribución normal con media 0 y desvío 1
#' r_norm <- gen_rand_distributions(.distribution=rnorm, 
#'                                  .n_obs=1000, 
#'                                  .n_samples=3, 
#'                                  mean=0, sd=1)
#' 
#' # Para corroborar, se agrupa por la muestra y se calcula el promedio y desvío 
#' # Se observa que el promedio se aproxima a 0 y el desvío se aproxima a 1
#' r_norm %>% 
#'   group_by(name) %>% 
#'   summarise(mean=mean(value), 
#'             sd=sd(value))
gen_rand_distributions <- function(.distribution, 
                                   .n_obs, 
                                   .n_samples, 
                                   .seed = 42,
                                   ...){
  
  args <- as.list(substitute(list(...)))[-1L]
  args[['n']] <- .n_obs
  
  set.seed(.seed)
  replicate(
      n        = .n_samples, 
      expr     = do.call(.distribution, args=args), 
      simplify = TRUE )  %>% 
  data.frame() %>%
  mutate(obs=1:.n_obs) %>%
  pivot_longer(-obs, names_to='sample_number', values_to='value') %>%
  mutate(sample_number=str_replace(sample_number, 'X',''))
  
}



# gen_rand_distributions(.distribution=rnorm, .n_obs=3, .n_samples=2,
#                                  mean=0, sd=1)
# 
# gen_rand_distributions(.distribution=rexp, .n_obs=3, .n_samples=2,
#                        rate=1)
# 
# gen_rand_distributions(.distribution=rchisq, .n_obs=3, .n_samples=2,
#                        df=2)
# 
# gen_rand_distributions(.distribution=runif, .n_obs=3, .n_samples=2,
#                        min=0, max=1)
# 
# gen_rand_distributions(.distribution=rgamma, .n_obs=3, .n_samples=2,
#                        shape=1)
# 
# gen_rand_distributions(.distribution=rbeta, .n_obs=3, .n_samples=2,
#                        shape1=2, shape2=4)
# 
# gen_rand_distributions(.distribution=rpois, .n_obs=3, .n_samples=2,
#                        lambda=1)
# 
# gen_rand_distributions(.distribution=rbinom, .n_obs=3, .n_samples=2,
#                        size=3, prob=0.5)
