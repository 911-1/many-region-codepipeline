#!/bin/bash

set -eu

# *** *Make ticket* Logic is required to only deploy items to regions in which the api endpoints reside. As an example, if managed AD doesn't exist in the region, buckets shouldn't be built, haulting deployment.

# *** Change this region list to the regions you want to deploy your application to
REGIONS="us-east-1 us-west-2"

# *** Change this to the name of the stack that will be created *in each* region to manage
# your codepipeline artifact bucket (calling it the same as your codepipeline stack, suffixed
# with '-artifact-bucket' makes most sense)
STACKNAME="multi-region-codepipeline-artifact-bucket"

for REGION in $REGIONS
do
  aws cloudformation create-stack --region $REGION --stack-name $STACKNAME --template-body file://artifact-buckets.yaml
done
