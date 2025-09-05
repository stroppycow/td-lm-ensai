#!/bin/sh
sudo apt-get update && sudo apt-get install -y inkscape
tlmgr update --self && tlmgr install luatex85 && tlmgr install tkz-tab
curl -sSL https://git.io/get-mo -o mo
chmod +x mo
sudo mv mo /usr/local/bin/
QUARTO_PREVIEW_URL=$1
export QUARTO_PREVIEW_URL=${QUARTO_PREVIEW_URL}
export ONYXIA_MODE=1
mo ./td-lm-ensai/.kube/ingress_template.yaml > ./ingress_output.yaml
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
