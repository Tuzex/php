#!/bin/bash

MODE=""
VERSION=""
ENV=""

echo "Which PHP mode do you want to use?"

OPTIONS=("cli" "fpm")
PS3="Choose a mode: "

select OPT in "${OPTIONS[@]}";
do
  case $OPT in
    * )
      if ! [[ "$OPT" =~ ^($(IFS="|"; printf '%s' "${OPTIONS[*]}"))$ ]]; then
        echo "Error: Unknown PHP mode" >&2
        exit 1;
      fi

      MODE="$OPT"
      break ;;
  esac
done

PS3='Choose a version: '
OPTIONS=("7.3" "7.4" "8.0")

echo "Which PHP version do you want to use?"
select OPT in "${OPTIONS[@]}";
do
  case $OPT in
    * )
      if ! [[ "$OPT" =~ ^($(IFS="|"; printf '%s' "${OPTIONS[*]}"))$ ]]; then
        echo "Error: Unknown PHP version" >&2
        exit 1;
      fi

      VERSION="$OPT"
      break ;;
  esac
done

PS3='Choose an environment: '
OPTIONS=("dev" "prod")

echo "Which environment do you want to use?"
select OPT in "${OPTIONS[@]}";
do
  case $OPT in
    * )
      if ! [[ "$OPT" =~ ^($(IFS="|"; printf '%s' "${OPTIONS[*]}"))$ ]]; then
        echo "Error: Unknown environment" >&2
        exit 1;
      fi

      ENV="$OPT"
      break ;;
  esac
done

printf "\n"

FLAG=""
if [ "$ENV" = "dev" ]; then
  FLAG="--dev"
fi

CONTEXT="./$VERSION/$MODE"
REPO="codeasoft/php"
TAG="$VERSION-$MODE$FLAG"

DOCKER_BUILDKIT=1 docker build --target "$ENV" -t "$REPO":"$TAG" "$CONTEXT"
