Sys.getenv()
source("renv/activate.R")

if(Sys.getenv("ONYXIA_MODE", unset = "") == "1"){
  options(renv.config.repos.override = 'https://packagemanager.posit.co/cran/latest')
  renv::restore(prompt = FALSE)
  
  rstudioapi::terminalExecute(
    command = 'kubectl apply -f ./../ingress_output.yaml'
  )
  
  rstudioapi::terminalExecute(
    command = 'quarto preview --host 0.0.0.0 --port 5000'
  )
}

