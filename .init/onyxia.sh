#!/bin/sh

echo \
"
setHook('rstudio.sessionInit', function(newSession) {
  if (newSession && identical(getwd(), '${WORKSPACE_DIR}'))
  {
    message('Activation du projet RStudio')
    rstudioapi::openProject('${WORKSPACE_DIR}/td-lm-ensai')
  }
  if (newSession && identical(getwd(), '${WORKSPACE_DIR}/td-lm-ensai'))
  {
    options(repos = c(RSPM = 'https://packagemanager.posit.co/cran/latest'))
    renv::restore()
  }
}, action = 'append')
" >> /home/onyxia/.Rprofile