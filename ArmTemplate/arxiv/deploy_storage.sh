#!/bin/bash
# Create storage for a resource group
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/storage/template.json
