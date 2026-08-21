# Terraform configuration generated from Resource Plan
# Environment: dev
# Generated from deterministic resource plan (Phase 2)

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "test-guaranteed-rg-02"
    storage_account_name = "pgstor769179"
    container_name       = "tfstate-system"
    key                  = "apps/test04-dev/dev.tfstate"
    subscription_id      = "d6c69b8a-1b49-482e-80c0-95ccb98fd3c6"
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Merge var.environment into tags so every resource carries the environment label.
# This ensures var.environment is consumed and not dead code.
locals {
  common_tags = merge(var.tags, { environment = var.environment })
}

# ========================================
# Phase: 1 Foundation
# ========================================

# Module: main_rg (azurerm_resource_group)
module "main_rg" {
  source = "./modules/azure-resource-group"

  location = var.location
  name     = "test04-dev-rg"
  tags     = local.common_tags
}

# Shared Data Lookup: log_analytics (azurerm_log_analytics_workspace)
data "azurerm_log_analytics_workspace" "shared" {
  name                = "test-01-dev-infrastructure"
  resource_group_name = "platform-shared-rg"
}

# ========================================
# Phase: 2 Shared Infrastructure
# ========================================

# Shared Data Lookup: tfstate_storage (azurerm_storage_account)
data "azurerm_storage_account" "shared" {
  name                = "pgstor769179"
  resource_group_name = "test-guaranteed-rg-02"
}

# Module: shared_plan (azurerm_service_plan)
module "shared_plan" {
  source = "./modules/azure-app-service-plan"

  kind                = "Linux"
  location            = var.location
  name                = "test04-dev-plan"
  resource_group_name = module.main_rg.name
  sku = {
    tier     = "Basic"
    size     = "B1"
    capacity = 1
  }
  tags = local.common_tags
}

# ========================================
# Phase: 3 Data
# ========================================

# Module: serverless_api_db_cosmos (azurerm_cosmosdb_account)
module "serverless_api_db_cosmos" {
  source = "./modules/azure-cosmosdb-account"

  consistency_policy              = var.consistency_policy
  enable_automatic_failover       = true
  enable_multiple_write_locations = false
  geo_location                    = var.geo_location
  kind                            = "GlobalDocumentDB"
  location                        = var.location
  name                            = "test04-dev-cosmos"
  offer_type                      = "Standard"
  resource_group_name             = module.main_rg.name
  tags                            = local.common_tags
}

# Module: cosmos_sql_db (azurerm_cosmosdb_sql_database)
module "cosmos_sql_db" {
  source = "./modules/azure-cosmosdb-sql-database"

  account_name        = module.serverless_api_db_cosmos.name
  autoscale_settings  = null
  name                = "test04-dev-cosmos-sql-db"
  resource_group_name = module.main_rg.name
  tags                = local.common_tags
  throughput          = 400
}

# Module: cosmos_sql_container (azurerm_cosmosdb_sql_container)
module "cosmos_sql_container" {
  source = "./modules/azure-cosmosdb-sql-container"

  account_name        = module.serverless_api_db_cosmos.name
  autoscale_settings  = null
  database_name       = module.cosmos_sql_db.name
  indexing_policy     = null
  name                = "test04-dev-cosmos-sql-container"
  partition_key_path  = "/id"
  resource_group_name = module.main_rg.name
  tags                = local.common_tags
  throughput          = 400
  unique_key          = []
}

# ========================================
# Phase: 4 Compute
# ========================================

# Module: frontend_app (azurerm_static_site)
module "frontend_app" {
  source = "./modules/azure-static-site"

  app_settings = {
    BACKEND_API_URL = "https://${module.serverless_api_app.default_hostname}"
  }
  location            = var.location
  name                = "test04-dev-frontend-web-app"
  resource_group_name = module.main_rg.name
  sku_size            = "Free"
  sku_tier            = "Free"
  tags                = local.common_tags
}

# Module: serverless_api_app (azurerm_linux_web_app)
module "serverless_api_app" {
  source = "./modules/azure-linux-web-app"

  app_settings = {
    COSMOS_CONNECTION_STRING = module.serverless_api_db_cosmos.connection_strings[0]
    MONGODB_URI              = module.serverless_api_db_cosmos.connection_strings[0]
  }
  enable_system_identity = true
  https_only             = true
  location               = var.location
  name                   = "test04-dev-backend-3b6095"
  resource_group_name    = module.main_rg.name
  runtime_stack = {
    language = "node"
    version  = var.serverless_api_node_version
  }
  service_plan_id = module.shared_plan.id
  tags            = local.common_tags
}

# change-intel live webhook test

