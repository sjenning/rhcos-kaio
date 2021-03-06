# rhcos-kaio
The project generates an ignition file that, when injected into RHCOS, creates an all-in-one Kubernetes cluster

Latest RHCOS Images
https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.3/latest/

## Prereqs
* openssl
* cfssl

## Usage
* `cp base.ign.example base.ign` and edit `base.ign` with your ssh key
* update `EXTERNAL_API_HOSTNAME` in `make-pki.sh` to the DNS name of your AIO (this is so the apiserver cert can include that name and the `admin.kubeconfig` will contact the apiserver at this name)
* run `make-ignition` to create the `final.ign` file
* inject the final.ign into an RHCOS machine directly, or use `bootstrap-append.ign.example` to append the ignition file from another host if the injection mechanism does not allow large files.

## Follow Up
* from the repo root, `KUBECONFIG=$PWD/fake-root/var/lib/kubernetes/admin.kubeconfig`
* run `oc get nodes` to make sure you can access the AIO
* create the CoreDNS deployment with `oc apply -f coredns.yaml`
* verify the deployment is Running with `oc get pod -n kube-system`

## Clean up
`make-ignition.sh` will reuse certs if they already exist in `fake-root/var/lib/kubernetes`. To start clean, `rm -rf fake-root/var/lib/kubernetes final.ign`.
