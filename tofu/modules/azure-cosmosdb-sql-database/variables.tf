variable "name" {
  description = "Name of the Cosmos DB SQL database"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "account_name" {
  description = "Cosmos DB account name"
  type        = string
}

variable "throughput" {
  description = "Throughput (RU/s) for the database"
  type        = number
  default     = 400

  validation {
    condition     = var.throughput >= 400
    error_message = "Throughput must be at least 400 RU/s."
  }
}

variable "autoscale_settings" {
  description = "Autoscale settings (optional)"
  type = object({
    max_throughput = number
  })
  default = null
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

