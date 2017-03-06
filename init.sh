#!/bin/bash

BUCKET_CATS_DOGS="nickksun-cats-dogs/cats"
BUCKET_UNICORN="nickksun-cats-dogs/unicorns"
REGION="ap-southeast-2"
PARAMETER_STORE_NAME="unicorn"

SECRET_PATH=$(aws ssm get-parameters --region $REGION --name $PARAMETER_STORE_NAME --with-decryption --output text | awk '{print $4}')

if [ "$SECRET_PATH" != "" ]; then echo "secret='"$SECRET_PATH"';" >> /usr/share/nginx/html/app.js; fi

/usr/local/bin/aws --region $REGION s3 cp s3://$BUCKET_CATS_DOGS /usr/share/nginx/html/ --recursive
# copy unicorn images
if [ "$SECRET_PATH" != "" ]; then
mkdir /usr/share/nginx/html/$SECRET_PATH
/usr/local/bin/aws --region $REGION s3 cp s3://$BUCKET_UNICORN /usr/share/nginx/html/$SECRET_PATH --recursive
fi
