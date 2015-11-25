#!/bin/bash

set -e
AWS_DIR=~/.aws/aws-identities
ACCESS_FILE_NAME="aws-credentials"

hash grep 2>/dev/null || { echo >&2 "aws-identity requires grep, but it doesn't seem to be available.  Aborting."; exit 1; }

usage()
{
     echo "AWS identity switch"
     echo "usage: aws-id <account>"
     echo ""
     echo "<account> is a directory in $AWS_DIR containing EC2 certs and an AWS credentials file."
	 echo ""
}

if [ ! -d $AWS_DIR ]
then
	if [ ! -z $1 ]; then 
        echo "AWS credential directory $AWS_DIR does not exist."; fi
	exit
    
fi

if [ $# -lt 1 ]
then
    usage
    return 0
fi

COMMAND="export"
UNSET="unset"
SEPARATOR="="

if [ -f $AWS_DIR/$1 ]
then
    source export AWS_CONFIG_FILE${SEPARATOR}"${AWS_DIR}/$1"
    echo "Switched EC2 and AWS identity to $1"
fi