#!/bin/bash

#docker rmi goriok/cookieater:latest
docker build --force-rm --no-cache -t goriok/cookieater:0.0.6 . &&
docker push goriok/cookieater:0.0.6
