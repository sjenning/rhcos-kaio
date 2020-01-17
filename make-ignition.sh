#!/bin/bash

set -eu

echo "building PKI"
./make-pki.sh
echo "copy admin kubeconfig to home directories"
mkdir -p fake-root/root/.kube
cp fake-root/var/lib/kubernetes/admin.kubeconfig fake-root/root/.kube/config
mkdir -p fake-root/home/core/.kube
cp fake-root/var/lib/kubernetes/admin.kubeconfig fake-root/home/core/.kube/config
echo "transpiling files"
./filetranspile -i base.ign -f fake-root -o tmp.ign
echo "transpiling units"
./unittranspile -i tmp.ign -u units/containerized -o final.ign
rm -f tmp.ign
echo "Ignition file is ready in final.ign"
