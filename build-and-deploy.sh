#!/bin/bash

docker build -t ghcr.io/searedcircuit/rust-echo -f Dockerfile .
docker push ghcr.io/searedcircuit/rust-echo