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
#'                                  mean=0, sd=1,
#'                                  .plot=FALSE)
#' 
#' # Para corroborar, se agrupa por la muestra y se calcula el promedio y desvío 
#' # Se observa que el promedio se aproxima a 0 y el desvío se aproxima a 1
#' r_norm %>% 
#'   group_by(name) %>% 
#'   summarise(mean=mean(value), 
#'             sd=sd(value))
gen_rand_distributions <- function(.distribution_random,
                                   .distribution_density,
                                   .n_obs, .n_samples, 
                                   .seed = 42, .plot = TRUE, ...){
  
  distribucion <- get_title(.function=deparse(substitute(.distribution_density)))
  
  args <- as.list(substitute(list(...)))[-1L]
  params <- paste0(names(args), "=", args, collapse = ", ")
  args[['n']] <- .n_obs
  
  set.seed(.seed)
  distributions <- replicate(
    n        = .n_samples,
    expr     = do.call(.distribution_random, args = args),
    simplify = TRUE
  )  %>% data.frame() %>%
    mutate(obs = 1:.n_obs) %>%
    pivot_longer(-obs, names_to = 'sample_number', values_to = 'value') %>%
    mutate(sample_number = str_replace(sample_number, 'X', ''))
  
  if (.plot==TRUE) {
    distributions %>%
      ggplot() +
      geom_density(aes(x = value, group = sample_number),
                   color='lightgrey', alpha=0.5)+
      stat_function(fun = .distribution_density, n = .n_obs,
                    args = list(...), color='#61d92e', size=1.2) +
      labs(x='x', y='f(x)', 
           title=paste0("<span style='color:black'>",distribucion,"</span>",
                        "<span style='color:#61d92e'>  (",params,")</span>"), 
           subtitle = paste0("<span style='color:darkgrey'>", .n_samples,
                             ' distribuciones aleatorias de ',.n_obs,
                             ' observaciones cada una</span>'))+
      theme_minimal()+
      theme(
        plot.title = ggtext::element_markdown(family="Malgun Gothic", 
                                              size = 14, hjust = 0.5),
        plot.subtitle = ggtext::element_markdown(hjust=0.5))
  } else {
    distributions
  }
}



# Funciones de Hadley para obtener el título de la función: 
# https://stackoverflow.com/questions/8379570/get-functions-title-from-documentation
pkg_topic <- function(package, topic, file = NULL) {
  # Find "file" name given topic name/alias
  if (is.null(file)) {
    topics <- pkg_topics_index(package)
    topic_page <- subset(topics, alias == topic, select = file)$file
    
    if(length(topic_page) < 1)
      topic_page <- subset(topics, file == topic, select = file)$file
    
    stopifnot(length(topic_page) >= 1)
    file <- topic_page[1]    
  }
  
  rdb_path <- file.path(system.file("help", package = package), package)
  tools:::fetchRdDB(rdb_path, file)
}



pkg_topics_index <- function(package) {
  help_path <- system.file("help", package = package)
  
  file_path <- file.path(help_path, "AnIndex")
  if (length(readLines(file_path, n = 1)) < 1) {
    return(NULL)
  }
  
  topics <- read.table(file_path, sep = "\t", 
                       stringsAsFactors = FALSE, comment.char = "", quote = "", header = FALSE)
  
  names(topics) <- c("alias", "file") 
  topics[complete.cases(topics), ]
}

get_title <- function(.function){
  target <- gsub("^.+/library/(.+)/help.+$", "\\1", 
                 utils:::index.search(.function, find.package()))
  doc.txt <- pkg_topic(target, .function) 
  return(doc.txt[[1]][[1]][1])
  
}
