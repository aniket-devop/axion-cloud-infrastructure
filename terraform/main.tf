module "resource_group" {
  for_each = var.environments

  source = "./modules/resource-group"

  name     = each.value.resource_group.name
  location = var.azure_location
}

module "acr" {
  for_each = var.environments

  source = "./modules/acr"

  name                = each.value.acr.name
  resource_group_name = module.resource_group[each.key].name
  location            = var.azure_location
  sku                 = each.value.acr.sku

  depends_on = [
    module.resource_group
  ]
}

module "aks" {
  for_each = var.environments

  source = "./modules/aks"

  name                = each.value.aks.name
  resource_group_name = module.resource_group[each.key].name
  location            = var.azure_location
  dns_prefix          = each.value.aks.name
  kubernetes_version  = each.value.aks.kubernetes_version
  node_count          = each.value.aks.node_count
  vm_size             = each.value.aks.vm_size

  depends_on = [
    module.acr
  ]
}

