#!/bin/bash

EXTRA_ARGS=""

# If KUBECONFIG is set, mount the file into the container and set KUBECONFIG accordingly
if [ -n "${KUBECONFIG}" ]; then
    IFS=':' read -ra ADDR <<< "${KUBECONFIG}"
    for i in "${ADDR[@]}"; do
        EXTRA_ARGS+=" -v ${i}:${i}"
    done

    EXTRA_ARGS="-e KUBECONFIG=$KUBECONFIG ${EXTRA_ARGS}"
fi


docker run --rm --net=host -v "${HOME}/.kube:/helm/.kube" -v "${HOME}/.config/helm:/helm/.config/helm" -v "${PWD}:/wd" --user "$(id -u):$(id -g)" --workdir /wd $EXTRA_ARGS ghcr.io/helmfile/helmfile:v1.1.9 helmfile "$@"
