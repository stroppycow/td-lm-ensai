#!/bin/sh
cd td-lm-ensai
R -e "options(renv.config.repos.override = 'https://packagemanager.posit.co/cran/latest')" -e  "renv::restore()"
cd ..
echo \
"
setHook('rstudio.sessionInit', function(newSession) {
  print(getwd())
  if (newSession && identical(getwd(), '${WORKSPACE_DIR}'))
  {
    message('Activation du projet RStudio')
    rstudioapi::openProject('${WORKSPACE_DIR}/td-lm-ensai', newSession = TRUE)
  }
}, action = 'append')

" >> /home/onyxia/.Rprofile