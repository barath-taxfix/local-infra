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