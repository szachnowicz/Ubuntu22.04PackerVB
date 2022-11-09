#!/usr/bin/env bash

PACKER_LOG=1 packer build -force "./"

echo -e "\e Done!"