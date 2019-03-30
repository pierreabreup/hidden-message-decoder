#!/bin/bash

bundle install

set -e

exec "$@"
