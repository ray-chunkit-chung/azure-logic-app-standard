#!/bin/bash
# Create workflow on existing logic app standard
az logic workflow create \
  --resource-group $RESOURCEGROUP_NAME \
  --subscription $SUBSCRIPTION_NAME \
  --location $LOCATION \
  --name "test_workflow_V2" \
  --definition ArmTemplate/workflowV2/template.json
