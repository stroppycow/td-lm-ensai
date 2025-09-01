#!/bin/sh
DIRNAME_TD=td-lm-ensai
cd ./${DIRNAME_TD}
RScript -e "options(repos = c(RSPM = 'https://packagemanager.posit.co/cran/latest'))" -e  "renv::restore()"
cd ..
echo \
"
setHook('rstudio.sessionInit', function(newSession) {
  print(getwd())
  if (newSession && identical(getwd(), '${WORKSPACE_DIR}'))
  {
    message('Activation du projet RStudio')
    rstudioapi::openProject('${WORKSPACE_DIR}/${DIRNAME_TD}', newSession = TRUE)
  }
}
}, action = 'append')


  
" >> /home/onyxia/.Rprofile