source("renv/activate.R")

if(file.exists("./../onyxia")){
  setHook('rstudio.sessionInit', function(newSession) {
    message('Activation du projet RStudio')
    rstudioapi::sendToConsole(
      code = "options(renv.config.repos.override = 'https://packagemanager.posit.co/cran/latest')",
      execute = TRUE,
      echo = TRUE,
      focus = TRUE,
      animate = FALSE
    )
    rstudioapi::sendToConsole(
      code = "renv::restore(prompt = FALSE)",
      execute = TRUE,
      echo = TRUE,
      focus = TRUE,
      animate = FALSE
    )
    
    rstudioapi::openProject('${WORKSPACE_DIR}/td-lm-ensai', newSession = FALSE)
    
    rstudioapi::terminalExecute(
      command = 'kubectl apply -f ./../ingress_output.yaml'
    )
    
    rstudioapi::terminalExecute(
      command = 'quarto preview --host 0.0.0.0 --port 5000'
    )
    
  }, action = 'append')
}

