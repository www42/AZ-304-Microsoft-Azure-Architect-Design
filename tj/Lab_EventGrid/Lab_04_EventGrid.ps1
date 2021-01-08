# ====================================================================
# Lab_04  Implement Azure Logic Apps integration with Azure Event Grid
# ====================================================================

# similar to AZ-300T04 Mod 01 Lab

Connect-AzAccount
Get-AzContext  | fl *

# Exercise 0: Prepare the lab environment
# ---------------------------------------
# Two ARM templates
dir Allfiles/Labs/04/azuredeploy30304suba.json              # RG
dir Allfiles/Labs/04/azuredeploy30304rga.json               # VM, Nic, VNet, PiP, NSG

cp  Allfiles/Labs/04/azuredeploy30304*.json $HOME

# Deploy RG
$location = 'westeurope'
New-AzSubscriptionDeployment `
-Location $location `
-Name az30304subaDeployment `
-TemplateFile $HOME/azuredeploy30304suba.json `
-rgLocation $location `
  -rgName 'az30304a-labRG'
  
# Deploy VM (Windows server 2019), etc
New-AzResourceGroupDeployment `
  -Name az30304rgaDeployment `
  -ResourceGroupName 'az30304a-labRG' `
  -TemplateFile $HOME/azuredeploy30304rga.json `
  -TemplateParameterFile $HOME/azuredeploy30304rga.parameters.json `
  -AsJob
  
Get-Job
  

Register-AzResourceProvider -ProviderNamespace 'Microsoft.EventGrid'

# Exercise 1: Configure authentication and authorization for an Azure logic app
# -----------------------------------------------------------------------------
$password = 'Pa55w.rd1234.@z304'
$securePassword = ConvertTo-SecureString -Force -AsPlainText -String $password
$az30304aadapp = New-AzADApplication -DisplayName 'az30304aadsp' `
                                     -HomePage 'http://az30304aadsp' `
                                     -IdentifierUris 'http://az30304aadsp' `
                                     -Password $securePassword

New-AzADServicePrincipal -ApplicationId $az30304aadapp.ApplicationId.Guid -SkipAssignment                                  

$ApplicationId = Get-AzADServicePrincipal -DisplayName az30304aadsp | % ApplicationId

$SubscriptionId = Get-AzSubscription | % Id
$TenantId = Get-AzSubscription | % TenantId

# Task 2
# Portal: az30304aadsp -> Reader -> az30304a-labRG



# Exercise 2: Implement an Azure logic app
# ----------------------------------------
# Task 1: Portal -> Create Logic App
# Task 2: Portal -> Logic App Designer -> Blank Logic App
#                -> Trigger: Event Grid
#                            Resource Type: Resource Group
#                            
# Task 3: Portal -> Next Step: Condition 
#                              If 
#                                  Microsoft.Compute/virtualMachines/write
#                              Then
#                                  Send email
# Task 4: Portal -> Action: Send email


# Exercise 3: Implement an event subscription
# -------------------------------------------





# Clean up
# ---------
Get-AzResourceGroup | Format-Table -Property ResourceGroupName,Location,ProvisioningState
rm  $env:HOME/azuredeploy30304*.json
