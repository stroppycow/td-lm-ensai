#!/bin/sh
sudo apt-get update && sudo apt-get install -y inkscape
tlmgr update --self && tlmgr install luatex85 && tlmgr install tkz-tab
echo \
"
setHook('rstudio.sessionInit', function(newSession) {
  if (newSession && identical(getwd(), '${WORKSPACE_DIR}'))
  {
    message('Activation du projet RStudio')
    rstudioapi::openProject('${WORKSPACE_DIR}/td-lm-ensai', newSession = TRUE)
  }
}, action = 'append')
" >> /home/onyxia/.Rprofile
echo \
"
options(renv.config.repos.override = 'https://packagemanager.posit.co/cran/latest')
renv::restore(prompt = FALSE)
" >> /home/onyxia/work/td-lm-ensai/.Rprofile