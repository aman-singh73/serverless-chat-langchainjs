output "id" {
  description = "The ID of the Redis Cache"
  value       = azurerm_managed_redis.this.id
}

output "name" {
  description = "The Name of the Redis Cache"
  value       = azurerm_managed_redis.this.name
}

output "hostname" {
  description = "The Hostname of the Redis Cache"
  value       = azurerm_managed_redis.this.hostname
}

output "primary_access_key" {
  description = "The Primary Access Key for the Redis Cache"
  value       = azurerm_managed_redis.this.default_database[0].primary_access_key
  sensitive   = true
}

output "ssl_port" {
  description = "The SSL Port of the Redis Cache"
  value       = azurerm_managed_redis.this.default_database[0].port
}

output "primary_connection_string" {
  description = "The Primary Connection String for the Redis Cache"
  value       = "rediss://:${azurerm_managed_redis.this.default_database[0].primary_access_key}@${azurerm_managed_redis.this.hostname}:${azurerm_managed_redis.this.default_database[0].port}"
  sensitive   = true
}
