#Optional Script as the Github Action check if RG exist - Should Update Script to automate RG creation in Azure & Repo + Secrets Creation in Github
#https://github.com/cli/cli/pull/2529

$projectName="yourproject"
$location="westeurope"
$resourceGroupName="${projectName}-dev-rg"
$appName="http://${projectName}"
$scope=$(az group create --name $resourceGroupName --location $location --query 'id')

$sp = az ad sp list --spn $appName --query '[].objectId' -o tsv
az role assignment create --role "Contributor" --assignee $sp --scope $scope

#Only use the below line to create the SPN (only once)
#az ad sp create-for-rbac --name $appName --role Contributor --scopes $scope --sdk-auth
