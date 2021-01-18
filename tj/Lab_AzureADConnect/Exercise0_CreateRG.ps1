# Exercise 0: Prepare the lab environment

$location = 'westeurope'

Test-AzDnsAvailability -DomainNameLabel foo69118 -Location $location

cd Allfiles/Labs/10/

New-AzSubscriptionDeployment `
  -Location $location `
  -Name az30310subaDeployment `
  -TemplateFile azuredeploy30310suba.json `
  -rgLocation $location `
  -rgName 'az30310a-labRG'

