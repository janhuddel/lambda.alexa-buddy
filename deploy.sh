#!/bin/bash

FUNCTION_NAME=alexa-buddy

BASEDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
THIS=`basename "$0"`

BUILD_DIR="$BASEDIR/build"
DIST_DIR="$BASEDIR/dist"

# create directories
if [ -d $BUILD_DIR ]; then
    rm -rf $BUILD_DIR
fi
mkdir $BUILD_DIR

if [ -d $DIST_DIR ]; then
    rm -rf $DIST_DIR
fi
mkdir $DIST_DIR

# copy files
cp -r ./*.js $BUILD_DIR
cp -r node_modules $BUILD_DIR

# create package
pushd $BUILD_DIR > /dev/null
zip -r "$DIST_DIR/function.zip" *
popd > /dev/null

# deploy package
aws lambda update-function-code --function-name $FUNCTION_NAME --zip-file fileb://$DIST_DIR/function.zip
