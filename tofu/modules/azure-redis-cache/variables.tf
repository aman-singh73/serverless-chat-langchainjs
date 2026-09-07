variable "name" {
  description = "Name of the Redis Cache"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "sku_name" {
  description = "The SKU name for Azure Managed Redis (e.g., Balanced_B0, Balanced_B1, MemoryOptimized_M10)"
  type        = string
  default     = "Balanced_B0"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
