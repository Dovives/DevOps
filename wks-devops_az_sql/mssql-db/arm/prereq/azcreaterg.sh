#!/bin/bash

#create Resource Group if not exist 
if [ $(az group exists --name $1) = false ]; then
    az group create --name $1 --location $2
fi