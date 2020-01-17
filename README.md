# rhcos-kaio
The project generates an ignition file that, when injected into RHCOS, creates an all-in-one Kubernetes cluster

## Prereqs
* openssl
* cfssl

## Usage
* `cp base.ign.example base.ign` and edit `base.ign` with your ssh key
* run `make-ignition` to create the `final.ign` file
* inject the final.ign into an RHCOS machine directly, or use `bootstrap-append.ign.example` to append the ignition file from another host if the injection mechanism does not allow large files.
