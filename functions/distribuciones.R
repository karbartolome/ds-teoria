#' Title
#'
#' @param .distribution 
#' @param .n_obs 
#' @param .n_samples 
#' @param .seed 
#' @param ... 
#'
#' @return
#' @export
#'
#' @examples
#' 
#' r_norm <- gen_rand_distributions(.distribution=rnorm, .n_obs=1000, .n_samples=3, 
#'                                  mean=0, sd=1)
#' 
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
  pivot_longer(-obs) %>%
  mutate(name=str_replace(name, 'X','Random '))
  
}



