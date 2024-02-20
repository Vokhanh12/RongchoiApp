#!/bin/bash
for i in 1
do
cowsay -f dragon Loading...
export PATH="$PATH":"$HOME/.pub-cache/bin"
dart pub global activate flutterfire_cli
flutterfire configure
done