resource "azurerm_storage_account" "infriqa_demo_insecure" {
  name                     = "infriqademoinsecure"
  resource_group_name      = "rg-infriqa-demo"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access  = false
  min_tls_version          = "TLS1_2"
  enable_https_traffic_only = true
}