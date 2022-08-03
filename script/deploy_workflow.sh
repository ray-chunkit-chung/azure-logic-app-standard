#!/bin/bash
# Create workflow on existing logic app standard
az logicapp deployment source config-zip \
  --name $LOGIC_APP_NAME \
  --resource-group $RESOURCEGROUP_NAME \
  --subscription $SUBSCRIPTION_NAME \
  --src MyBuildArtifact.zip
