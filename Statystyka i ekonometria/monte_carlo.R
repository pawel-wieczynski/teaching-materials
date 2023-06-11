if(!require('pacman')) install.packages('pacman')
pacman::p_load(dplyr, purrr, ggplot2, ggpubr)
options(scipen = 10)

circle_area_mc = function(nsim) {
  
  df = map(1:2, ~ runif(nsim, -0.5, 0.5)) %>%
    as.data.frame(col.names = c('x', 'y')) %>%
    mutate(circle = x^2 + y^2 <= 0.5^2)
  
  approx_pi =  4 * (sum(df$circle) / length(df$circle))
  
  p = ggplot(df) +
    geom_point(aes(x = x, y = y, color = circle), size = 0.5) +
    labs(
      x = '', y =''
      ,title = paste0('Monte Carlo approximation of pi = ', approx_pi)
      ,subtitle = paste0('N = ', nsim)
    ) +
    theme_bw() + 
    theme(legend.position = 'none')
  
  return(p)
  
}

set.seed(2137)
map(c(1e2, 1e3, 1e4, 1e5), circle_area_mc) %>%
  ggarrange(plotlist = ., nrow = 2, ncol = 2)
