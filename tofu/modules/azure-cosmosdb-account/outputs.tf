output "id" {
  description = "The ID of the Cosmos DB Account"
  value       = azurerm_cosmosdb_account.this.id
}

output "name" {
  description = "The name of the Cosmos DB Account"
  value       = azurerm_cosmosdb_account.this.name
}

output "endpoint" {
  description = "The endpoint of the Cosmos DB Account"
  value       = azurerm_cosmosdb_account.this.endpoint
}

output "primary_key" {
  description = "The primary key for the Cosmos DB Account"
  value       = azurerm_cosmosdb_account.this.primary_key
  sensitive   = true
}

output "primary_readonly_key" {
  description = "The primary readonly key for the Cosmos DB Account"
  value       = azurerm_cosmosdb_account.this.primary_readonly_key
  sensitive   = true
}

# connection_strings output removed — attribute deprecated in azurerm v3.117+
# Use primary_key + endpoint outputs to build connection strings programmatically
output "connection_strings" {
  description = "A list of connection strings for the Cosmos DB Account, programmatically constructed to avoid deprecation issues"
  value       = var.kind == "MongoDB" ? [
    "mongodb://${azurerm_cosmosdb_account.this.name}:${azurerm_cosmosdb_account.this.primary_key}@${azurerm_cosmosdb_account.this.name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${azurerm_cosmosdb_account.this.name}@"
  ] : [
    "AccountEndpoint=${azurerm_cosmosdb_account.this.endpoint};AccountKey=${azurerm_cosmosdb_account.this.primary_key};"
  ]
  sensitive   = true
}



