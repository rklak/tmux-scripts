#!/usr/bin/env bash

if [ -d "${PWD}/develop" ]; then
  cd "${PWD}/develop"
else
  cd "${PWD}/../develop"
fi
