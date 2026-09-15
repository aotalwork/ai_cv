#!/usr/bin/env bash
set -o errexit

bundle install

bin/rails db:prepare

bin/rails tailwindcss:build

bin/rails assets:precompile