#!/bin/bash

docker build -t ghcr.io/searedcircuit/rust-echo-arm -f Dockerfile-arm64 .
docker push ghcr.io/searedcircuit/rust-echo-arm