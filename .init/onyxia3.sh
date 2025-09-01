#!/bin/sh

echo \
"
setHook('rstudio.sessionInit', function(newSession) {
  if (newSession && identical(getwd(), '${WORKSPACE_DIR}'))
  {
    message('Activation du projet RStudio')
    rstudioapi::openProject('${WORKSPACE_DIR}/td-lm-ensai', newSession = TRUE)
  }
}, action = 'append')

if(identical(getwd(), '${WORKSPACE_DIR}/td-lm-ensai')){
    rstudioapi::sendToConsole('options(repos = c(RSPM = \"https://packagemanager.posit.co/cran/latest\"))', execute = TRUE)
    rstudioapi::sendToConsole('renv::restore()', execute = TRUE)
}
  
" >> /home/onyxia/.Rprofile