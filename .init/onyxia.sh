#!/bin/sh

echo \
"
setHook('rstudio.sessionInit', function(newSession) {
  if (newSession && identical(getwd(), '/home/onyxia'))
  {
    message('Activation du projet RStudio')
    rstudioapi::openProject('/home/onyxia/td-lm-ensai')
  }
}, action = 'append')
" >> /home/onyxia/.Rprofile