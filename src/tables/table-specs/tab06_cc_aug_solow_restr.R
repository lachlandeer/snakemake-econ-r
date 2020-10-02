#' tab06_cc_aug_solow_restr.R
#'
#' contributors: @lachlandeer, @julianlanger, @bergmul
#'
#' Table for convergence of augmented solow model with restrictions, 
#' Table 6 of MRW
#'

# Create Table
stargazer(data$model_aug_cc_restr_ols_subset_nonoil,
          data$model_aug_cc_restr_ols_subset_intermediate,
          data$model_aug_cc_restr_ols_subset_oecd,
          initial.zero = TRUE,
          align = FALSE,
          style = "qje",
          title = "Test for Conditional Convergence - Restricted \\& Augmented Model",
          dep.var.labels = "Log(GDP '85) - Log(GDP '60)",
          column.labels = c("Non-Oil", "Intermediate", "OECD"),
          covariate.labels = c("log(GDP per capita 1960)",
                               "log(I / GDP) - log(n + g + $\\delta$)",
                               "log(school) - log(n + g + $\\delta$)"
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
