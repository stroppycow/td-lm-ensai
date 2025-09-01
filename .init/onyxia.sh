echo \
"
setHook('rstudio.sessionInit', function(newSession) {
  if (newSession && identical(getwd(), 'td-lm-ensai'))
  {
    message('Activation du projet RStudio')
    rstudioapi::openProject('td-lm-ensai')
  }
}, action = 'append')
" >> /home/onyxia/.Rprofile