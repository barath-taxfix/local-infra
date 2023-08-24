#! /usr/bin/env bash
brew install mkcert
wget https://github.com/sigoden/argc/releases/download/v1.8.0/argc-v1.8.0-aarch64-apple-darwin.tar.gz
tar xzvf argc-v1.8.0-aarch64-apple-darwin.tar.gz
sudo mv argc /usr/local/bin