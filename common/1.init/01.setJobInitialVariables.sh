#!/bin/bash

# Set Job Common Variables

echo 'Computing initial local variables for job'

JOB_DATE=$(date +%y-%m-%d)
echo "##vso[task.setvariable variable=JOB_DATE;]${JOB_DATE}"

JOB_DATETIME=$(date +%y-%m-%d'T'%H.%M.%S_%3N)
echo "JOB_DATETIME=${JOB_DATETIME}"
echo "##vso[task.setvariable variable=JOB_DATETIME;]${JOB_DATETIME}"

JOB_SUIF_TAG=${JOB_SUIF_TAG:-main}
echo "##vso[task.setvariable variable=JOB_SUIF_TAG;]${JOB_SUIF_TAG}"

SUIF_FIXES_DATE_TAG=${SUIF_FIXES_DATE_TAG:-latest}
echo "##vso[task.setvariable variable=SUIF_FIXES_DATE_TAG;]${SUIF_FIXES_DATE_TAG}"

MY_AZ_ACR_URL=${MY_AZ_ACR_URL:-'Pipeline MUST provide an ACR URL'}
echo "##vso[task.setvariable variable=MY_AZ_ACR_URL;]${MY_AZ_ACR_URL}"
