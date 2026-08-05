variable "name" {
  description = "Name of the Cosmos DB SQL container"
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

variable "database_name" {
  description = "Cosmos DB SQL database name"
  type        = string
}

variable "partition_key_path" {
  description = "Partition key path"
  type        = string
}

variable "throughput" {
  description = "Throughput (RU/s) for the container"
  type        = number
  default     = 400
}

variable "autoscale_settings" {
  description = "Autoscale settings (optional)"
  type = object({
    max_throughput = number
  })
  default = null
}

variable "unique_key" {
  description = "Unique key paths (optional)"
  type        = list(string)
  default     = []
}

variable "indexing_policy" {
  description = "Indexing policy (optional)"
  type = object({
    indexing_mode = string
    included_paths = list(string)
    excluded_paths = list(string)
  })
  default = null
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

