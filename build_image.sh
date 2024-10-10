#!/bin/bash
set -e

ECR_URL="${ECR_URL:=}"
REPOSITORY="${REPOSITORY:=}"
VERSION_TAG="${VERSION_TAG:=}"

if [[ -z $ECR_URL ]]; then
  echo "expected env ECR_URL to be set but was empty"
  exit 1
fi

if [[ -z $REPOSITORY ]]; then
  echo "expected env REPOSITORY to be set but was empty"
  exit 1
fi

if [[ -z $VERSION_TAG ]]; then
  echo "expected env VERSION_TAG to be set but was empty"
  exit 1
fi

imageTagWithVersion="$ECR_URL/$REPOSITORY:flask-app-$VERSION_TAG"

echo "Image tag is '$imageTagWithVersion'"

echo "building container image..."
docker build -t $imageTagWithVersion .

echo "pushing container image to '$imageTagWithVersion'..."
docker push $imageTagWithVersion