#' tab03_ucc_solow.R
#'
#' contributors: @lachlandeer, @julianlanger, @bergmul
#'
#' Table for unconditional convergence of textbook solow model, 
#' Table 3 of MRW
#'

# Create Table
stargazer(data$model_ucc_ols_subset_nonoil,
          data$model_ucc_ols_subset_intermediate,
          data$model_ucc_ols_subset_oecd,
          initial.zero = TRUE,
          align = FALSE,
          style = "qje",
          title = "Test for Unconditional Convergence",
          dep.var.labels = "Log(GDP '85) - Log(GDP '60)",
          column.labels = c("Non-Oil", "Intermediate", "OECD"),
          covariate.labels = c("log(GDP per capita 1960)"
                               ),
          omit.stat = c("rsq", "ser", "F"),
          df = FALSE,
          digits = 3,
          font.size = "scriptsize",
          table.layout ="-dc#-t-a-s=n",
          no.space = TRUE,
          type = "latex",
          out = opt$out
          )
