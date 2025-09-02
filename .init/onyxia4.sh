#!/bin/sh
# cd td-lm-ensai
# R -e "options(renv.config.repos.override = 'https://packagemanager.posit.co/cran/latest')" -e  "renv::restore()"
# tlmgr update --self && tlmgr install luatex85 && tlmgr install tkz-tab
echo \
"
setHook('rstudio.sessionInit', function(newSession) {
  if (newSession && identical(getwd(), '${WORKSPACE_DIR}'))
  {
    message('Activation du projet RStudio')
    rstudioapi::openProject('${WORKSPACE_DIR}/td-lm-ensai', newSession = FALSE)
  }
}, action = 'append')
" >> /home/onyxia/.Rprofile