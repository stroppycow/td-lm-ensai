#!/bin/bash
QUARTO_PREVIEW_URL=$PERSONAL_INIT_ARGS
arrIN=(${QUARTO_PREVIEW_URL//./ })
export APP_NAME=${arrIN[0]}-nginx
export QUARTO_INGRESS_NAME=${arrIN[0]}
export QUARTO_PREVIEW_URL=${QUARTO_PREVIEW_URL}
TIMEOUT="300s"
LABEL="app=${APP_NAME}"

kubectl delete deployments ${APP_NAME}
kubectl delete pods -l ${LABEL}
kubectl delete pvc ${APP_NAME}
kubectl delete services ${APP_NAME}
kubectl delete ingress ${QUARTO_INGRESS_NAME}

rm ${HOME}/manifest_nginx.yaml
mo ${HOME}/work/td-lm-ensai/.kube/full_nginx_template.yaml > ${HOME}/manifest_nginx.yaml
kubectl apply -f ${HOME}/manifest_nginx.yaml

echo "Waiting for deployment ${APP_NAME} in namespace ${KUBERNETES_NAMESPACE} to roll out..."
kubectl rollout status deployment/${APP_NAME} -n ${KUBERNETES_NAMESPACE} --timeout=${TIMEOUT} || {
  echo "Deployment ${DEPLOYMENT} did not roll out in time."
  exit 1
}
echo "Deployment rollout completed."
kubectl wait pod -l ${LABEL} -n ${KUBERNETES_NAMESPACE} --for=condition=Ready --timeout=${TIMEOUT} || {
  echo "Some pods did not become Ready within ${TIMEOUT}."
  exit 1
}
POD=$(kubectl get pod -l ${LABEL} -o=name | cut -c5-)
ENTRIES=( "${HOME}/work/td-lm-ensai/_site"/* )
for e in "${ENTRIES[@]}"; do
  echo "Copy ${e} to pod"
  kubectl cp ${e} ${POD}:/usr/share/nginx/html
done
