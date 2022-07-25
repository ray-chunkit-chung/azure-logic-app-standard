#!/bin/bash
# Create a logic app consumption
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/logicAppBase/template.json
