#!/bin/bash

dockercompose=$1

./compose_undeploy.sh
./compose_deploy.sh ${dockercompose}
