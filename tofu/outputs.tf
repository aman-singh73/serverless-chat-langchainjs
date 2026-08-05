# Outputs for Terraform configuration

# Generated deterministically using Module Registry

output "main_rg_id" {
  description = "The ID of the Resource Group"
  value       = module.main_rg.id
}

output "main_rg_name" {
  description = "The name of the Resource Group"
  value       = module.main_rg.name
}

output "main_rg_location" {
  description = "The location of the Resource Group"
  value       = module.main_rg.location
}

output "shared_plan_id" {
  description = "The ID of the App Service Plan"
  value       = module.shared_plan.id
}

output "shared_plan_name" {
  description = "The name of the App Service Plan"
  value       = module.shared_plan.name
}

output "serverless_api_db_cosmos_id" {
  description = "The ID of the Cosmos DB Account"
  value       = module.serverless_api_db_cosmos.id
}

output "serverless_api_db_cosmos_name" {
  description = "The name of the Cosmos DB Account"
  value       = module.serverless_api_db_cosmos.name
}

output "serverless_api_db_cosmos_endpoint" {
  description = "The endpoint of the Cosmos DB Account"
  value       = module.serverless_api_db_cosmos.endpoint
}

output "serverless_api_db_cosmos_primary_key" {
  description = "The primary key for the Cosmos DB Account"
  sensitive   = true
  value       = module.serverless_api_db_cosmos.primary_key
}

output "serverless_api_db_cosmos_primary_readonly_key" {
  description = "The primary readonly key for the Cosmos DB Account"
  sensitive   = true
  value       = module.serverless_api_db_cosmos.primary_readonly_key
}

output "serverless_api_db_cosmos_connection_strings" {
  description = "A list of connection strings for the Cosmos DB Account, programmatically constructed to avoid deprecation issues"
  sensitive   = true
  value       = module.serverless_api_db_cosmos.connection_strings
}

output "cosmos_sql_db_id" {
  description = "The ID of the Cosmos DB SQL Database"
  value       = module.cosmos_sql_db.id
}

output "cosmos_sql_db_name" {
  description = "The name of the Cosmos DB SQL Database"
  value       = module.cosmos_sql_db.name
}

output "cosmos_sql_container_id" {
  description = "The ID of the Cosmos DB SQL Container"
  value       = module.cosmos_sql_container.id
}

output "cosmos_sql_container_name" {
  description = "The name of the Cosmos DB SQL Container"
  value       = module.cosmos_sql_container.name
}

output "frontend_app_id" {
  description = "The ID of the Static Web App"
  value       = module.frontend_app.id
}

output "frontend_app_name" {
  description = "The name of the Static Web App"
  value       = module.frontend_app.name
}

output "frontend_app_default_host_name" {
  description = "The default hostname of the Static Web App"
  value       = module.frontend_app.default_host_name
}

output "frontend_app_api_key" {
  description = "The API key for the Static Web App (sensitive)"
  sensitive   = true
  value       = module.frontend_app.api_key
}

output "serverless_api_app_id" {
  description = "The ID of the Linux Web App"
  value       = module.serverless_api_app.id
}

output "serverless_api_app_default_hostname" {
  description = "The default hostname of the Linux Web App"
  value       = module.serverless_api_app.default_hostname
}

output "serverless_api_app_identity_principal_id" {
  description = "The principal ID of the system-assigned identity"
  value       = module.serverless_api_app.identity_principal_id
}

output "serverless_api_app_name" {
  description = "The name of the Linux Web App"
  value       = module.serverless_api_app.name
}
