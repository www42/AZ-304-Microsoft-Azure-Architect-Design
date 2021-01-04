# Exercise 0: Prepare the lab environment
# ---------------------------------------
$location = 'westeurope'

dir Allfiles/Labs/08/azuredeploy30308suba.json  # RG only
cd Allfiles/Labs/08/

New-AzSubscriptionDeployment `
  -Location $location `
  -Name az30308subaDeployment `
  -TemplateFile azuredeploy30308suba.json `
  -rgLocation $location `
  -rgName 'az30308a-labRG'