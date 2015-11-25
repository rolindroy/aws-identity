#!/bin/bash

set -e
AWS_DIR=~/.aws/aws-identities
ACCESS_FILE_NAME="aws-credentials"

usage()
{
     echo "AWS identity switch"
     echo "usage: aws-id <account>"
     echo ""
     echo "usage: aws-id -add <account>"
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

if [ $1 == "-add" ]; then
    if [ ! -z $2 ]; then 
    
        printf "aws_access_key_id[ eg: WISAJMZ7DFCHAJMZ7DFCH] : "
        read -r accessKey
        printf "aws_secret_access_key[ eg: 09fdf5Ajffsfsdf3EsFsdfsdm6pfsdfs7yWT73Hz] : "
        read -r secretKey
        printf "region[ eg: us-east-1] : "
        read -r region
        keyfile=$AWS_DIR/$2
        touch $keyfile
        echo "[default]" >> $keyfile
        echo "aws_access_key_id = "$accessKey >> $keyfile
        echo "aws_secret_access_key = "$secretKey >> $keyfile
        echo "region = "$accessKey >> $region
    fi
else
    COMMAND="export"
    UNSET="unset"
    SEPARATOR="="

    if [ -f $AWS_DIR/$1 ]
    then
        source export AWS_CONFIG_FILE${SEPARATOR}"${AWS_DIR}/$1"
        echo "Switched EC2 and AWS identity to $1"
    fi
fi