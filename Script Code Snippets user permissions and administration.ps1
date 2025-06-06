

AZURE CLI : az role assignment list --all --assignee  user@abcde.onmicrosoft.com --output json --query '[].{principalName:principalName, roleDefinitionName:roleDefinitionName, scope:scope}' ##similar to the one above but with more details

AZ powershell:
Get-AzRoleAssignment -SignInName  user@abcde.onmicrosoft.com ## get all roles assigned for this user

Get-AzResourceGroup | ForEach-Object {
    Get-AzRoleAssignment -ResourceGroupName $_.ResourceGroupName | Where-Object { -not $_.Scope.Contains("managementGroups") -and $_.ObjectType -ne "ServicePrincipal" | Select-Object DisplayName } 
 }


 Get-AzRoleAssignment -RoleDefinitionId "8e3af657-a8ff-443c-a75c-546546564"  ## ID = owner PER SUB

Get-AzRoleAssignment -RoleDefinitionId "8e3af657-a8ff-443c-a75c-546546564" | where {($_.ObjectType -EQ "user")  }  | select DisplayName,SignInName,Scope ## list all owners with formating


AZURE Powerlshell RM
Get-AzureRmRoleAssignment| Where-Object RoleDefinitionName -like "*owner*" | fl

 
