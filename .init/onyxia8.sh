#!/bin/sh
sudo apt-get update && sudo apt-get install -y inkscape
tlmgr update --self && tlmgr install luatex85 && tlmgr install tkz-tab
curl -sSL https://git.io/get-mo -o mo
chmod +x mo
sudo mv mo /usr/local/bin/
QUARTO_PREVIEW_URL=$1
export QUARTO_PREVIEW_URL=${QUARTO_PREVIEW_URL}
mo ./td-lm-ensai/.kube/ingress_template.yaml > ./ingress_output.yaml
touch onyxia
cat << EOF > ~/.config/rstudio/rstudio-prefs.json
{
    "num_spaces_for_tab": 4,
    "insert_native_pipe_operator": true,
    "margin_column": 100,
    "auto_append_newline": true,
    "strip_trailing_whitespace": true,
    "auto_save_on_blur": true,
    "check_arguments_to_r_function_calls": true,
    "check_unexpected_assignment_in_function_call": true,
    "warn_variable_defined_but_not_used": true,
    "style_diagnostics": true,
    "theme": "Modern Dark",
    "editor-theme": "Tomorrow Night Bright",
    "posix_terminal_shell": "bash"
}
EOF
chown -R onyxia:users ~/.config/
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
