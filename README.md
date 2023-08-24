# `local-infra`

  Create a local cluster with TLS

## Required dependencies

  * `argc`
  * `terraform`
  * `mkcert`

Setup dependencies with

```bash
./setup.sh
```

## Setup the local cluster with `kind`

```bash
./tasks.sh up --init
```

## Destroy the cluster
```bash
./tasks.sh down
```
# Or avoid all that


```bash
brew install mkcert && cd stacks/local && terraform init && terraform apply -auto-approve -var cluster_name=<<YOUR_CLUSTER_NAME>>
``````

visit `https://mail.<<YOUR_CLUSTER_NAME>>.localhost`
