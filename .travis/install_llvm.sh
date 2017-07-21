#!/bin/bash

set -e

if [ -z "$LLVM_VERSION" ]; then
	echo "Missing LLVM_VERSION"
	exit 1
fi

if [ "$TRAVIS_OS_NAME" = "linux" ]; then
	wget -nv -O - http://llvm.org/apt/llvm-snapshot.gpg.key | sudo apt-key add -;
	sudo apt-add-repository -y 'deb http://llvm.org/apt/trusty llvm-toolchain-trusty-4.0 main';

	sudo apt-get -qq update
	sudo apt-get -qq install llvm-$LLVM_VERSION llvm-$LLVM_VERSION-dev;

	mkdir -p latest-llvm-symlinks;
	ln -s /usr/bin/llvm-config-$LLVM_VERSION latest-llvm-symlinks/llvm-config;
	export PATH=$PWD/latest-llvm-symlinks:$PATH;

elif [ "$TRAVIS_OS_NAME" = "osx" ]; then
	if [ "$LLVM_VERSION" = "4.0" ]; then
		brew install llvm-4.0
	elif [ "$LLVM_VERSION" = "3.9" ]; then
		brew install llvm-3.9
	elif [ "$LLVM_VERSION" = "3.8" ]; then
		brew install llvm-3.8
	elif [ "$LLVM_VERSION" = "3.7" ]; then
		brew install llvm-3.7
	else
		echo "Invalid llvm version: LLVM_VERSION=$LLVM_VERSION"
		exit 1
	fi
else
    echo "Invalid Travis os name: TRAVIS_OS_NAME=$TRAVIS_OS_NAME"
    exit 1
fi

llvm-config --version
