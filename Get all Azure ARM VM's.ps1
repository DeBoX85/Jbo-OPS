﻿param(
    [string]$tenantId="",
    [string]$file="c:\Temp\azureresources4TEST.csv"
) 

if ($tenantId -eq "") {
    #login-azurermaccount 
    $subs = Get-AzureRmSubscription 
} else {
    login-azurermaccount -tenantid $tenantId 
    $subs = Get-AzureRmSubscription -TenantId $tenantId 
}


$vmobjs = @()

foreach ($sub in $subs)
{
    
    Write-Host Processing subscription $sub.SubscriptionName

    try
    {

        Select-AzureRmSubscription -SubscriptionId $sub.SubscriptionId -ErrorAction Continue

        $vms = Get-AzureRmVm 

        foreach ($vm in $vms)
        {
            $vmInfo = [pscustomobject]@{
                'Subscription'=$sub.SubscriptionName
                'Mode'='ARM'
                'Name'=$vm.Name
                'ResourceGroupName' = $vm.ResourceGroupName
                'Location' = $vm.Location
                'VMSize' = $vm.HardwareProfile.VMSize
                'Status' = $null
                'AvailabilitySet' = $vm.AvailabilitySetReference.Id }
        
            $vmStatus = $vm | Get-AzureRmVM -Status
            $vmInfo.Status = $vmStatus.Statuses[1].DisplayStatus

            $vmobjs += $vmInfo

        }  
    }
    catch
    {
        Write-Host $error[0]
    }
}

$vmobjs | Export-Csv -NoTypeInformation -Path $file
Write-Host "VM list written to $file"