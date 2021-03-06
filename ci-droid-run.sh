#!/bin/bash

CI_DROID_REST_VERSION="1.0.7"
CI_DROID_TASKS_CONSUMER_VERSION="1.0.8"

echo "downloading CI-Droid REST part.."
APPLI_NAME=ci-droid-rest
curl http://repo1.maven.org/maven2/com/societegenerale/ci-droid/ci-droid-starter/$CI_DROID_REST_VERSION/ci-droid-starter-$CI_DROID_REST_VERSION-exec.jar --insecure -o $APPLI_NAME.jar
echo "building $APPLI_NAME image.."
docker build . -f Dockerfile-ci-droid --build-arg APPLI_NAME=$APPLI_NAME -t $APPLI_NAME

echo "downloading CI-Droid tasks consumer part.."
APPLI_NAME=ci-droid-tasks-consumer
curl http://repo1.maven.org/maven2/com/societegenerale/ci-droid/tasks-consumer/ci-droid-tasks-consumer-starter/$CI_DROID_TASKS_CONSUMER_VERSION/ci-droid-tasks-consumer-starter-$CI_DROID_TASKS_CONSUMER_VERSION-exec.jar --insecure -o $APPLI_NAME.jar
echo "building $APPLI_NAME image.."
docker build . -f Dockerfile-ci-droid --build-arg APPLI_NAME=$APPLI_NAME -t $APPLI_NAME


echo "starting Docker compose.."
# taken from https://mindbyte.nl/2018/04/05/run-rabbitmq-using-docker-compose-with-guest-user.html
docker-compose up







