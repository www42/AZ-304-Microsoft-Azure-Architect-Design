Login-AzAccount

Get-AzSubscription | ft Name,Id,State

$subscriptionId = 'c46281f7-38b7-4e1d-ba22-140cd892cd07'
Set-AzContext -Subscription $subscriptionId

Get-AzContext | fl Account,Subscription,Tenant

Get-AzResourceGroup | Sort-Object ResourceGroupName | ft ResourceGroupName,Location,ProvisioningState