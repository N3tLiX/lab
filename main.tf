locals {
  subnets = [
    {
      name : "AzureBastionSubnet"
      address_prefixes : ["10.255.0.0/26"]
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
      service_endpoints : [
        "Microsoft.AzureActiveDirectory"
      ]
      deligation : {
        name : null
        service_delegation : {
          actions : null
          name : null
        }
      }
    },

    {
      name : "sn-endpoints"
      address_prefixes : ["10.255.0.64/26"]
      enforce_private_link_endpoint_network_policies : false
      enforce_private_link_service_network_policies : false
      service_endpoints : [
        "Microsoft.AzureActiveDirectory",
        "Microsoft.Storage",
      ]
      deligation : {
        name : null
        service_delegation : {
          actions : null
          name : null
        }
      }
    },
    {
      name : "sn-services"
      address_prefixes : ["10.255.0.128/25"]
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
      service_endpoints : [
        "Microsoft.AzureActiveDirectory",
        "Microsoft.Storage",
      ]
      deligation : {
        name : null
        service_delegation : {
          actions : null
          name : null
        }
      }
    }
  ]
}

module "network" {
  for_each = { for subnet in local.subnets : subnet.name => subnet
  if subnet.name != "GatewaySubnet" && subnet.name != "AzureFirewallSubnet" && subnet.name != "AzureFirewallManagementSubnet" && subnet.name != "AzureBastionSubnet" && subnet.name != "RouteServerSubnet" }
  source                 = "Azure/naming/azurerm"
  version                = "0.1.1"
  suffix                 = [replace(replace(join("", (each.value.address_prefixes)), ".", "_"), "/", "__")]
  unique-length          = 12
  unique-include-numbers = true
}

output "subnet_suffix" {
  value = [for type in module.network : type.subnet.name_unique]
}
