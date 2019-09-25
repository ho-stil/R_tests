# reproducible excample for plotly issue 762:

library(crosstalk)
library(plotly)
TestDF <- data.frame(a = c(1:9), b = c(rep(c(1:3), 3)), c = c(1:9/10), d = LETTERS[rep(c(1:3),3)])
d_list <- unique(TestDF$d)
shared_Test_all <- SharedData$new(TestDF, group = "Test")
shared_Test <- vector("list", 3)
p1 <- plot_ly(type = "scatter", mode = "markers")  
for (i in 1:length(d_list)) {
  shared_Test[[i]] <- SharedData$new(TestDF[TestDF$d == d_list[i],], group = "Test")
  p1 <- add_trace(p1, data = shared_Test[[i]], x = ~a, y = ~b, name = ~d, error_y = ~list(array = c))
}
bscols(list(filter_select("d", "filter by d", shared_Test_all, ~d, multiple = TRUE),
            bscols(plot_ly(data = shared_Test_all, x = ~a, y = ~b, 
                           type = "scatter", mode = "markers",
                           error_y = ~list(array = c)),
                   plot_ly(data = shared_Test_all, x = ~a, y = ~b, name = ~d, 
                           type = "scatter", mode = "markers",
                           error_y = ~list(array = c)),
                   p1)))
