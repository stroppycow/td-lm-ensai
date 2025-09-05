#!/bin/sh
sudo apt-get update && sudo apt-get install -y inkscape
tlmgr update --self && tlmgr install luatex85 && tlmgr install tkz-tab
curl -sSL https://git.io/get-mo -o mo
chmod +x mo
sudo mv mo /usr/local/bin/
QUARTO_PREVIEW_URL=$1
export QUARTO_PREVIEW_URL=QUARTO_PREVIEW_URL
mo ./td-lm-ensai/.kube/ingress_template.yaml > ./td-lm-ensai/.kube/ingress_output.yaml
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

rstudioapi::terminalExecute(
   command = 'kubectl apply -f ./.kube/ingress_output.yaml'
)

rstudioapi::terminalExecute(
   command = 'quarto preview --host 0.0.0.0 --port 5000'
)
" >> /home/onyxia/work/td-lm-ensai/.Rprofile


