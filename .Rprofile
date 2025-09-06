source("renv/activate.R")

if(file.exists("./../onyxia")){
  file.remove("./../onyxia")
  setHook('rstudio.sessionInit', function(newSession) {
    message('Activation du projet RStudio')
    renv::install("rstudioapi", prompt = FALSE)
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
    
    rstudioapi::terminalExecute(
      command = 'kubectl apply -f ./../ingress_output.yaml',
      show = FALSE
    )
    
    rstudioapi::terminalExecute(
      command = 'quarto preview --host 0.0.0.0 --port 5000',
      show = FALSE
    )
  }, action = 'append')
}
