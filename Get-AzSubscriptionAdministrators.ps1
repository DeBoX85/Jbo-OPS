#requires -modules Az.Accounts
##https://github.com/slapointe/azure-scripts/tree/master/rbac/list-subscription-administrators

Connect-AzAccount  

[CmdletBinding()]
param(
    [string[]]
    $SubscriptionName = ((Get-AzSubscription).Name | ? { $_ -ne 'Access to Azure Active Directory' })
)
$ErrorActionPreference = 'Stop'
# save current Azure context
$currentContext = Get-AzContext

$SubscriptionName | % {
  if((Get-AzContext).Subscription.Name -ne $_) {
    $null = Set-AzContext -Subscription $_
  }
  Write-Host ('Fetching administrators for subscription: {0}' -f $_)
  @{
    subscription = (Get-AzContext).Subscription.Name
    admins = Get-AzRoleAssignment -IncludeClassicAdministrators | Where-Object RoleDefinitionName -match "administrator|^owner$" | Select-Object ObjectId, SignInName, DisplayName, Scope, RoleDefinitionName
  }
}

# restore Azure context to what it was
$null = $currentContext | Select-AzContext