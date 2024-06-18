# A fun welcome message
message("Hi Frieder, GET YOUR SHIT DONE!")

# Color output to console using R.nvim
# if (requireNamespace("colorout", quietly = TRUE)) {
#     if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
#     devtools::install_github("jalvesaq/colorout")
# }
library(colorout)
colorout::setOutputColors(
    index    = "\x1b[38;2;122;162;247m", # Blue for index
    normal   = "\x1b[38;2;192;202;245m", # Foreground for normal text

    number   = "\x1b[38;2;187;154;247m", # Magenta for numbers
    negnum   = "\x1b[38;2;158;206;106m", # Green for negative numbers
    zero     = "\x1b[38;2;125;207;255m", zero.limit = 0.01, # Cyan for zero
    infinite = "\x1b[38;2;224;175;104m", # Orange for infinite

    string   = "\x1b[38;2;187;154;247m", # Magenta for strings
    date     = "\x1b[38;2;224;175;104m", # Orange for dates
    const    = "\x1b[38;2;224;175;104m", # Orange for constants

    true     = "\x1b[38;2;158;206;106m", # Green for true
    false    = "\x1b[38;2;247;118;142m", # Red for false

    warn     = "\x1b[38;2;224;175;104m", # Orange for warnings
    stderror = "\x1b[38;2;247;118;142m", error = "\x1b[38;2;247;118;142m", # Red for errors

    verbose  = FALSE
)

# # This avoids polluting .GlobalEnv with the object r
# local({
#     r <- getOption("repos")
#     r["CRAN"] <- "https://cran.rstudio.com/"
#     options(repos = r)
# })

# Disable completion from the language server
options(
    languageserver.server_capabilities =
        list(completionProvider = FALSE, completionItemResolve = FALSE)
)

# options(continue = " ")
