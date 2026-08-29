output "resource_group_name" {
  description = "Resource Group name"
  value       = module.resource_group["dev"].name
}

output "acr_name" {
  description = "ACR name"
  value       = module.acr["dev"].name
}

output "acr_login_server" {
  description = "ACR login server"
  value       = module.acr["dev"].login_server
}

output "aks_name" {
  description = "AKS cluster name"
  value       = module.aks["dev"].name
}

output "aks_id" {
  description = "AKS cluster ID"
  value       = module.aks["dev"].id
}

output "aks_kube_config" {
  description = "AKS kubeconfig"
  value       = module.aks["dev"].kube_config
  sensitive   = true
}
