#!/bin/bash
image="$1"
curl -u 'xxx:xxxx' "https://artifactory.gitlab.com/v2/${image}/tags/list"
