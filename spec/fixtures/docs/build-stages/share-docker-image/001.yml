dist: trusty

jobs:
  include:
    - stage: build docker image
      script:
      - echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
      - docker build -t travis-ci-build-stages-demo .
      - docker images
      - docker tag travis-ci-build-stages-demo $DOCKER_USERNAME/travis-ci-build-stages-demo
      - docker push $DOCKER_USERNAME/travis-ci-build-stages-demo
    - stage: test
      script: docker run --rm $DOCKER_USERNAME/travis-ci-build-stages-demo cat hello.txt
    - script: docker run --rm $DOCKER_USERNAME/travis-ci-build-stages-demo cat hello.txt