resource "azurerm_kubernetes_cluster" "easynotes-dev-aks" {
  name                = "easynotes-dev-aks"
  location            = azurerm_resource_group.easynotes-dev-rg.location
  resource_group_name = azurerm_resource_group.easynotes-dev-rg.name
  dns_prefix          = "easynotes-dev-aks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_b2s" 
    vnet_subnet_id   = azurerm_subnet.easynotes-dev-subnet-aks.id
  }

  network_profile {
    network_plugin    = "kubenet"
    network_policy    = "calico"
    dns_service_ip    = "10.0.0.10"  # Adjust based on your VNet address space
    service_cidr      = "10.0.0.0/16"  # Adjust based on your VNet address space
  }

  role_based_access_control_enabled = true

  identity {
    type = "SystemAssigned"
  }

}



