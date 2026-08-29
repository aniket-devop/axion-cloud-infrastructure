variable "azure_location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "eastus"
}

variable "environments" {
  description = "Environment-specific infrastructure configuration"

  type = map(object({
    resource_group = object({
      name = string
    })

    acr = object({
      name = string
      sku  = string
    })

    aks = object({
      name               = string
      kubernetes_version = string
      node_count         = number
      vm_size            = string
    })
  }))
}