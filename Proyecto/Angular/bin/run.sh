#!/usr/bin/env bash
# create-create-deploy-image-image.sh
#
# This file:
#  - To create and deploy docker image in production server
#
# Version 0.1.0
#
# Authors:
#  - Dani Bernedo <dbernedo@fobos-e.com>
#
# Usage:
#  ./scripts/run.sh -v 1.3

set -e

usage()
{
cat << EOF
usage: $0 [options]

To create and deploy docker image in production server

OPTIONS:
   -h      Help
   -p      Run in production.
   -v      Version to tag docker image

EXAMPLES

$ ./bin/create-deploy-image.sh -v 1.4 -p

EOF
}

ssh=$(which ssh)

VERSION="latest"
NAME="fobos-cli-2"

REMOTE_HOST="devops@37.48.94.136"
REMOTE_PATH="/usr/local/docker/compose/fobos-cli-2"

while getopts “hpv:” OPTION
do
  case $OPTION in
    h)
      usage | more
      exit 1
      ;;
    v)
      VERSION=$OPTARG
      ;;
    p)
      PRODUCTION=true
      ;;
    ?)
      usage | more
      exit
      ;;
  esac
done

IMAGE_NAME="${NAME}"

if [[ ! -z ${VERSION} ]]; then
  IMAGE_NAME="${IMAGE_NAME}:${VERSION}"
fi

if [[ ! -z ${PRODUCTION} ]]; then
  $ssh -p 89 ${REMOTE_HOST} "sed -i 's|\\s*image\\:\\ ${NAME}\\:.*$|\\ \\ image: ${NAME}:${VERSION}|g' ${REMOTE_PATH}/docker-compose.yml"
  $ssh -p 89 ${REMOTE_HOST} "cd ${REMOTE_PATH} && docker-compose rm -f && docker-compose up -d"
else
  sed -i "s|\s*image\:\ ${NAME}\:.*$|\ \ image: ${NAME}:${VERSION}|g" docker-compose-pre.yml
  docker-compose -f docker-compose-pre.yml rm -f && docker-compose -f docker-compose-pre.yml up -d
fi