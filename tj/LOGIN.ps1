Login-AzAccount

$subscriptionId = 'c46281f7-38b7-4e1d-ba22-140cd892cd07'
Get-AzSubscription -SubscriptionId $subscriptionId | fl Name,Id,State

Set-AzContext -Subscription $subscriptionId
Get-AzContext | fl Account,Subscription,Tenant

$rgName = 'az30308c-labRG'
$rgName = 'az30308a-labRG'
$location = 'northeurope'

Get-AzVM -ResourceGroupName $rgName -Status | fl Name,Location,PowerState
Get-AzVM -ResourceGroupName $rgName -Status | % OSProfile | % WindowsConfiguration

# After agent installation task
$vm = Get-AzVM -Name 'az30308a-vm1-test'
$vm.OSProfile.AllowExtensionOperations = $true

# Sacha Dillmann brainymotion