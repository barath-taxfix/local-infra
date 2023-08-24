#! /usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# @describe developer tools
# @option -h --help show help

# @cmd initialize terraform
# @alias i
# @arg stack=local stack to update
init() {
  pushd ${SCRIPT_DIR}/stacks/${argc_stack} > /dev/null
  terraform init
  popd > /dev/null
}

# @cmd create or update infrastructure
# @alias u
# @flag -i --init also initialize the infrastructure
# @arg stack=local stack to update
up() {
  if [ "${argc_init}" ]; then
    init
  fi
  pushd ${SCRIPT_DIR}/stacks/${argc_stack} > /dev/null
  terraform apply -auto-approve
  popd > /dev/null
}

# @cmd create or update infrastructure
# @alias d
# @arg stack=local stack to destroy
down() {
  pushd ${SCRIPT_DIR}/stacks/${argc_stack} > /dev/null
  terraform destroy -auto-approve
  popd > /dev/null
}

eval "$(argc --argc-eval "$0" "$@")"