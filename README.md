# azure-logic-app-standard
azure logic app to track new file upload to one drive. If new, add an Azure queue

# workflow
```
az logic workflow create -n demo -g test -l centralus --definition .\src\workflow.json
```

# Get customDomainVerificationId
```
az graph query -q "Resources | join kind=leftouter (ResourceContainers | where type=='microsoft.resources/subscriptions' | project subscriptionName=name, subscriptionId) on subscriptionId | where type == 'microsoft.web/sites'| project customVerificationId = tostring(properties.customDomainVerificationId), subscriptionId, subscriptionName | distinct *"
```

```
az graph query -q "Resources | project name, properties.customDomainVerificationId, type | where type == 'microsoft.web/sites'"
```

# Getting started


Login Azure
```
az login
```

Create resource group (Assume a subscription exists)
```
az group create --subscription $SUBSCRIPTION_NAME \
                --location $LOCATION \
                --name $RESOURCEGROUP_NAME \
                --tags "$TAGS"
```

Create storage account
```
az storage account create --subscription $SUBSCRIPTION_NAME \
                          --name $STORAGE_NAME \
                          --resource-group $RESOURCEGROUP_NAME
```

Create queues in storage account
```
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/queue/template.json
```
<!-- ```
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/queue/template.json \
                           --parameters ArmTemplate/queue/parameters.json

az storage queue create --subscription $SUBSCRIPTION_NAME \
                        --name $STORAGE_QUEUE_NAME \

az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/logicApp/template.json
``` -->


Create api connection to one drive and queue in this resource group
```
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/api_queue/template.json
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/api_onedrive/template.json
```

Create logic app to connect one drive and queue
```
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/logicApp/template.json
```

Start the logic app
```
az logicapp start --subscription $SUBSCRIPTION_NAME \
                  --resource-group $RESOURCEGROUP_NAME \
                  --name $LOGICAPP_NAME
```



# Delete everything

```
az group delete --name $RESOURCEGROUP_NAME
```

