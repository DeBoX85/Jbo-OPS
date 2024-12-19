#Troublesthooting delete Azure Subnet
##If you have this issue then you will be presented with an error like this:
##Failed to delete subnet
##Failed to delete subnet ‘app_subnet’. 
##Error: Subnet app_subnet is in use by cp-rg/providers/Microsoft.Network/virtualNetworks/cp-vnet/subnets/app_subnet/serviceAssociationLinks/AppServiceLink’>
##cp-vnet/app_subnet/AppServiceLink and cannot be deleted. In order to delete the subnet, delete all the resources within the subnet. See aka.ms/deletesubnet.

#The standard method to correct this is to recreate the resource. If you can recreate the resource that was in the Subnet before, 
#then you can reattach it to the subnet. This then brings the resources back to the state they were before. From here you can then Disconnect the Resource and then delete the Subnet.

##look for ‘serviceAssociationLinks’ in the readout"

$rgname = "cp-rg"
$subnet = "app_subnet"
$vnet = "cp-vnet"
az network vnet subnet show --resource-group $rgname --name $subnet --vnet $vnet

#Examples

az network vnet subnet show --resource-group Stuff --name AzureBastionSubnet --vnet Stuff-app-vnet


az network vnet subnet show --resource-group rgname-cn-xxxxx-p-rgp-001 --name abcd-xxxx-p-vne-001 --vnet abcd-cn-xxxxx-p-vne-001
