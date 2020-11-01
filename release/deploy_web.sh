#!/bin/bash

set -e
cd game
wasm-pack build --release --target web -- --no-default-features --features osm_viewer,wasm,wasm_s3
cd pkg
# Temporarily point to the tmp data, which is gzipped
rm -f system
ln -s ~/tmp_mass_import_output/data/system/ system
aws s3 sync . s3://abstreet/osm_demo
# Undo that symlink swap
git checkout system
echo "Have the appropriate amount of fun: http://abstreet.s3-website.us-east-2.amazonaws.com/osm_demo"
